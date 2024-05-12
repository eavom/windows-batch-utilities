REM Code from "github.com/the-mova"
REM ##################################################
@echo off
color B
mode con: cols=50 lines=12
set probar=
set/a lnum=0

:LOADING
title Loading...
set probar=%probar%!!!!!!!
cls
echo -------------------------------------------------
echo                    Loading Bar
echo -------------------------------------------------
echo.
echo          Code Is Loading...
echo          ===================================
echo          %probar%
echo          ===================================
echo.                              Please Wait...
echo.
echo -------------------------------------------------
ping localhost -n 2 >nul
set/a lnum=%lnum% +1
if %lnum%==5 goto THANKS
goto LOADING

:THANKS
cls
echo.
echo -------------------------------------------------
echo                    Thank you
echo -------------------------------------------------
echo.
echo.
echo   Thanks for using my code.
echo.
echo                      "github.com/the-mova"
echo -------------------------------------------------
pause

REM ##################################################
REM Code from "github.com/the-mova"
