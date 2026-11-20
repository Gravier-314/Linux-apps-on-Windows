wsl --install -d Ubuntu

wsl --update

wsl -l -v

wsl -d Ubuntu sudo apt update && sudo apt upgrade -y
printf '[boot]\nsystemd=true\n' | sudo tee -a /etc/wsl.conf

wsl --shutdown