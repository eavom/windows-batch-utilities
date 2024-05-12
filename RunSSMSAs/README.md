# Run SSMS As...

This small batch file allows you to run SQL Server Management Studio as a different domain User using Windows Authentication.

With first login it saves your username in Environment Variable. Means moving forward it uses the same username and ask your for password only. In order to  clear the stored username, you can run below command in cmd. The below command only works if your current working directory is the one where your **RunSSMSAs.bat** file is copied.
 
`RunSSMSAs.bat /clear`
 
