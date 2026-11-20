
Here is a simple setup to run any linux app on a windows machine.
**Without any commands**

This guide will help you unclock the power of linux without opening terminal*.

---
# Overview

WSL --> Bazaar --> Any app you want --> Shortcut/pin to taskbar/addd on desktop

This configuration uses [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/install).
Using WSL, users will be able to use [Bazaar](https://apps.gnome.org/fr/Bazaar/) (wich is the app store for many linux distributions).
Using Bazaar, users will be able to install apps **without commands**

# Step by step

1. **Install WSL**
- Download wsl_setup.bat (click on the script name on the repo --> top right "download raw")
- Run the **wsl_setup.bat** script
- Just download it and double click on it. .bat are windows shell scripts
- It will take some time
- You will be prompted to create a user (for linux). I suggest to use your usual windows credentials.

2. **Install Bazaar**
- Download bazaar.bat
- Run the **bazaar.bat** script
- You will be prompted for the Ubuntu password
- It will take some time

3. **Create a shortcut for Bazaar**
- Right click on your desktop --> new --> shortcut
- Paste the following line in the field :
```
 wsl -d Ubuntu flatpak run io.github.kolunmi.Bazaar
```
<img width="550" alt="Capture d’écran 2026-11-19 172430" src="https://github.com/user-attachments/assets/829a979c-07a8-4c7b-92c7-a14a800d468a" />
<img width="550" alt="Capture d’écran 2026-11-19 172550" src="https://github.com/user-attachments/assets/626d5893-db60-49d9-838d-a13f83fdbd34" />

- Name the shortcut
- IMPORTANT : right click your shortcut --> pin to start menu

5. Install an application
	1. Open Bazaar (like a normal windows app) (give it some time, it has to start WSL)
	2. Find your app
	3. Download it


6. Create a shortcut for your app
	1. On [Flathub website](https://flathub.org/en/apps/io.github.kolunmi.Bazaar), look for the app name
	2. replace `io.github.kolunmi.Bazaar` with the app name
	3. Example for organic maps :
```
 wsl -d Ubuntu flatpak run app.organicmaps.desktop
```
<img width="2060" height="1072" alt="Capture d’écran 2026-11-19 180440" src="https://github.com/user-attachments/assets/5eda3167-9892-43f5-a43f-fa4892598718" />

<br>

**Fun fact:**
You can change the icon of the app using an image
There is the Bazaar and OrganicMaps ico link in this repo.


<img width="750"  alt="Capture d’écran 2026-11-19 185226" src="https://github.com/user-attachments/assets/f093730f-60c4-4909-b226-db8dbac0400e" />
<img width="750"  alt="Capture d’écran 2026-11-19 185409" src="https://github.com/user-attachments/assets/6ebbb2d1-b95c-4862-9241-78a899e92d1d" />


# Script and command explaination


**wsl_setup.bat**
```bash
wsl --install -d Ubuntu #this installs an instance of Ubuntu on your machine
wsl --update
wsl -l -v               #this lists wsl instances on your system
wsl -d Ubuntu sudo apt update && sudo apt upgrade -y #this makes sure your Ubuntu is up to date
printf '[boot]\nsystemd=true\n' | sudo tee -a /etc/wsl.conf #This ensure systemd is enable (it is required)
wsl --shutdown #this restarts wsl to apply changes
```
More info about [systemd](https://wiki.archlinux.org/title/Systemd)
```bash
wsl -d Ubuntu [...] #This tells WSL to run [...] on Ubuntu (you could have multiple subsystems)
```

**Bazaar.bat**
This checks for a distro called Ubuntu, then installs flatpak on it, to install Bazaar, with some logic to manage errors.
``` bash
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
```
More info about [flatpak](https://flatpak.org/)

```
 wsl -d Ubuntu flatpak run io.github.kolunmi.Bazaar
```
This is the command to run Bazaar through Ubuntu on WSL



NOTE

To uninstall ubuntu, there is need to:
```
wsl --unregister Ubuntu

```
