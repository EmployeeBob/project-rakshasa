@echo off
color 1a
title Rakshasa Portable Hacking System for Windows
set /a d=0
set /a cl=0
echo This is Rakshasa Portable Hacking Systems for Windows versions 7 and above. Free-use code by hoboguy.
echo This is the Batch (.bat) version: Run this application as admin.
echo WARNING: What the user does with this program is their own decision! **Use at your own risk!**
echo.
pause

:help
echo 'Q' - Quit the program
echo 'P' - Change your IP address
echo 'E' - Open control panel
echo 'D' - Disable external controls
echo 'N' - Enable external controls
echo 'I' - Everything about your device
echo 'M' - Shutdown a computer remotely
echo 'S' - Unlock a protected file
echo 'R' - Restart this device
echo 'L' - Find a user's password
echo 'T' - The list of all the users
echo.

:commands
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a
choice /c QPEDNIMSRLT
if %errorlevel%==1 exit /b
if %errorlevel%==2 goto incognito
if %errorlevel%==3 goto 
if %errorlevel%==4 goto netshdisable
if %errorlevel%==5 goto netshenable
if %errorlevel%==6 goto info
if %errorlevel%==7 goto mobile
if %errorlevel%==8 goto 
if %errorlevel%==9 goto restart
if %errorlevel%==10 goto listhack_users
if %errorlevel%==11 goto list_users

) else (
goto error

:mobile
shutdown /i
pause
cls
goto help

:error
echo This option does not exist. Please check main menu once again!
pause
cls
goto help


:info
systeminfo | findstr /c:"Host" 
systeminfo | findstr /c:"Domain" 
systeminfo | findstr /c:"System" 
systeminfo | findstr /c:"Version" 
systeminfo | findstr /c:"Manufacturer" 
systeminfo | findstr /c:"Model" 
systeminfo | findstr /c:"Type" 
systeminfo | findstr /c:"Memory" 
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a
echo Public IP:                 %PublicIP%
ipconfig | find /i "IPv4"
pause
cls
goto help

:netshdisable
netsh interface show interface
set /p item=Disable: 
netsh interface set interface "%item%" Disable
goto help

:netshenable
netsh interface show interface
set /p item=Enable:
netsh interface set interface "Wi-Fi" Enable
goto help

:restart
shutdown /r
pause
cls
goto help

:list_users
net user
pause
cls
goto help

:listhack_users
net user
goto hack


:hack
set /p u=Hack Username:
if %u%==users goto listhack users
set /p p=New Password: 
net user %u% %p% 
if not %d%==1 :hackerror
if %d%==1 echo - command: net user %u% %p%
echo Command is being processed.
pause
goto menu

:adminhack
cd %userprofile%\Downloads
md rakshasa.{ED7BA470-8E54-465E-825C-99712043E01C}
start rakshasa.{ED7BA470-8E54-465E-825C-99712043E01C}
echo.
goto commands

:hackfile
copy "C:\Program Files\WinRAR\Unrar.exe"
set pswd=0
set dest=%temp%\%random%
md %dest%

:rar
set/p "name=Enter File Name:"
if "%name%"=="" goto nerror
goto gpath

:nerror
echo Please input your file name.
pause
cls
goto rar

:gpath
set/p "path=Enter full Path:"
if "%path%"=="" goto perror
goto next

:perror
echo Please input your file path.
goto gpath

:next
if exist "%path%\%name%" goto start

) else (
goto path

:path
echo That file does not exist.
goto rar

:start
set /a pswd=%pswd%+1
unrar e -inul -p%pswd% "%path%\%%" "%dest%"
IF /I %errorlevel% equ 0 goto finish
goto start

:finish
rd %dest% /q /s
Del "Unrar.exe"
echo You have cracked the password.
echo File = %name%
echo Password = %pswd%
goto :commands


:incognito
echo [A] Set Static IP 
echo [B] Set DHCP 
echo. 

:choice 
choice /c AB>nul
if %errorlevel%==1 goto A
if %errorlevel%==2 goto B
) else (
echo Selection does not exist!
goto choice 

:A 
echo Click "Enter" to continue.
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a
set /p IP_Addr=%PublicIP%
echo Enter the first two digits in your IP address, %PublicIP%
set /p D_Gate=
echo Enter the last three digits in your IP address, %PublicIP%
set /p Sub_Mask=
netsh interface ip set address "LAN" static %IP_Addr% %Sub_Mask% %D_Gate% 1 
netsh int ip show config
echo Updated system information.
goto info

:B 
echo Resetting IP Address and Subnet Mask For DHCP 
netsh int ip set address name = "LAN" source = dhcp
ipconfig /renew
echo Here are the new settings for %computername%: 
netsh int ip show config
goto commands

:END
