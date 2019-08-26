#Pre-requsites


echo "Please input your django project name."
read projectname

django-admin startproject $projectname
mv $projectname app
cp ./scripts/requirements.txt ./app/requirements.txt
echo "STATIC_ROOT = os.path.join(ROOT_DIR, 'static_files')" >> ./app/$projectname/settings.py
echo "ROOT_DIR = os.path.dirname(BASE_DIR)" >> ./app/$projectname/settings.py

while true; do
    read -p "Do you wish to use the certbot for https? [y/n]" yn
    case $yn in
        [Yy]* ) cp ./scripts/docker-compose.yml ./docker-compose.yml;
                mkdir nginx;
                cp ./scripts/nginx.conf ./nginx/nginx.conf;
                sudo ./init-letsencrypt.sh; 
                break;;

        [Nn]* ) cp ./scripts/docker-compose-wo-certbot.yml ./docker-compose.yml;
                mkdir nginx;
                cp ./scripts/nginx-wo-certbot.conf ./nginx/nginx.conf;
                docker-compose up app nginx;
                break;;

        * ) echo "Please answer yes or no.";;
    esac
done