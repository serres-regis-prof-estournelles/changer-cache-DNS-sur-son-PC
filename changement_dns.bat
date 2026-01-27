@echo off
title Changement de DNS

:: Verification des droits administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Ce script necessite des droits administrateur !
    echo Faites un clic droit sur le fichier et choisissez "Executer en tant qu'administrateur"
    pause
    exit
)

:MENU
cls
echo ===============================================================================
echo                           CHANGEMENT DE DNS
echo ===============================================================================
echo.
echo  Changer de DNS est une amelioration simple, gratuite et rapide pour gagner
echo  en vitesse de navigation sur Internet.
echo.
echo  Classement typique (du plus rapide au moins rapide) :
echo  1. Cloudflare     : plus rapide globalement
echo  2. Google DNS     : tres bon, parfois egal a Cloudflare selon la localisation
echo  3. DNS de votre FAI : Souvent le plus lent
echo.
echo ===============================================================================
echo.
echo  Choisissez une option :
echo.
echo  [1] Configurer DNS Cloudflare (1.1.1.1 / 1.0.0.1)
echo  [2] Configurer DNS Google (8.8.8.8 / 8.8.4.4)
echo  [3] Retablir DNS du FAI (automatique)
echo  [4] Quitter
echo.
echo ===============================================================================
echo.

set /p choix="Entrez votre choix (1-4) : "

if "%choix%"=="1" goto CLOUDFLARE
if "%choix%"=="2" goto GOOGLE
if "%choix%"=="3" goto FAI
if "%choix%"=="4" goto FIN
echo Choix invalide !
timeout /t 2 >nul
goto MENU

:CLOUDFLARE
cls
echo Configuration du DNS Cloudflare...
echo.
netsh interface ip set dns "Ethernet" static 1.1.1.1
netsh interface ip add dns "Ethernet" 1.0.0.1 index=2
netsh interface ip set dns "Wi-Fi" static 1.1.1.1
netsh interface ip add dns "Wi-Fi" 1.0.0.1 index=2
echo.
echo DNS Cloudflare configure !
echo.
pause
goto MENU

:GOOGLE
cls
echo Configuration du DNS Google...
echo.
netsh interface ip set dns "Ethernet" static 8.8.8.8
netsh interface ip add dns "Ethernet" 8.8.4.4 index=2
netsh interface ip set dns "Wi-Fi" static 8.8.8.8
netsh interface ip add dns "Wi-Fi" 8.8.4.4 index=2
echo.
echo DNS Google configure !
echo.
pause
goto MENU

:FAI
cls
echo Retablissement du DNS automatique (FAI)...
echo.
netsh interface ip set dns "Ethernet" dhcp
netsh interface ip set dns "Wi-Fi" dhcp
echo.
echo DNS du FAI retabli !
echo.
pause
goto MENU

:FIN
cls
echo.
echo Merci !
echo.
timeout /t 2 >nul
exit
