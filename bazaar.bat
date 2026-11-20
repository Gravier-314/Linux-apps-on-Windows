@echo off
REM Installs Flatpak, adds Flathub, and installs Bazaar in WSL Ubuntu

wsl -d Ubuntu -- true || (echo Ubuntu WSL distro not found. This means that there is not ditro named Ubuntu on your system. & pause & exit /b 1)

REM Flatpak = app packaging system; needs sudo (asks for your Linux password)
wsl -d Ubuntu -- sudo apt update || goto :fail
wsl -d Ubuntu -- sudo apt install -y flatpak || goto :fail

REM Flathub = the app repository Bazaar and Organic Maps come from
wsl -d Ubuntu -- flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || goto :fail

REM Bazaar = graphical app store for Flathub
wsl -d Ubuntu -- flatpak install --user -y --noninteractive flathub io.github.kolunmi.Bazaar || goto :fail

echo Done.
pause
exit /b 0

:fail
echo A step failed - see the message above.
pause
exit /b 1