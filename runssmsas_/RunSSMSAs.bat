@echo off

setlocal EnableDelayedExpansion
title [Run SSMS As]
set domain=.

:main
	call :setconfiguration
	cls
	echo ==========================================
	echo   Run SQL Server Management Studio AS...
	echo ==========================================
	echo.
		
		if "!_SSMS_USERNAME!" == "" (
			set /p vUserName=_       Username : !domain!\
			set /p vPassword=_       Password : 
		) else (
			set vUserName=!_SSMS_USERNAME!
			echo _       Username : !domain!\!_SSMS_USERNAME!
			set /p vPassword=_       Password : 
		)
	echo.
	echo ==========================================

	if /i "!_ASK_ME_LATER!" == "Y" ( call :saveusername %vUserName% ) 
	if "!_ASK_ME_LATER!" == "" ( call :saveusername %vUserName% ) 
	
	call :openappas !vUserName! !vPassword!
goto :eof

:openappas
	set iUserName=%~1
	set iPassword=%~2
	
	echo !iPassword! | runas /netonly /user:!domain!\!iUserName! "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe" 
	echo.
	cls

		if not "!errorlevel!" == "0" (
			call :showmessage "ERROR" "Failed" "Invalid username/Password..."
			goto :main
		) else (
			call :showmessage "SUCCESS" "Success" "Attemting to run SSMS as !domain!\!iUserName! ..."
			echo.
		)
goto :eof

:saveusername

	if "!_SSMS_USERNAME!" == "" (
		choice /m "Save username:"
		echo ==========================================
		if not "!errorlevel!" == "1" (
			choice /m "Ask me later:"
			
			if not "!errorlevel!" == "1" ( 
				setx _ASK_ME_LATER "N" 
				REM reg delete HKCU\Environment /F /V _ASK_ME_LATER
				REM setx _ASK_ME_LATER "" & reg delete HKCU\Environment /F /V _ASK_ME_LATER
			) else ( 
				setx _ASK_ME_LATER "Y" 
			)
			
		) else (
				setx _SSMS_USERNAME "%1"
				setx _ASK_ME_LATER "N"
		)
	)
goto :eof

:showmessage
	set messageType=%~1
	set messageTitle=%~2
	set messageText=%~3

	if /i "!messageType!" == "ERROR" (
		echo ER
		call :reconfiguration "FC"
	)
	if /i "!messageType!" == "SUCCESS" (
		echo SC
		call :reconfiguration "0A"
	)
	echo ==========================================
	echo                   !messageTitle!
	echo ==========================================
	echo.
	echo !messageText!
	echo.
	pause
goto :eof

:setconfiguration
	color B
	mode con: cols=43 lines=15
goto :eof

:reconfiguration
	color %~1
	mode con: cols=43 lines=10
goto :eof
