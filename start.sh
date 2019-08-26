cd ./app
django-admin startproject boilerplate

while true; do
    read -p "Do you wish to use the certbot?" yn
    case $yn in
        [Yy]* ) sudo ./init-letsencrypt.sh; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done