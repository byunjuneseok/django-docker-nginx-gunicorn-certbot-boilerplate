TEST_FLAG=0

for arg in "$@"
do
    case $arg in
        -t|--test)
        TEST_FLAG=1
        shift
        ;;
        -h|--help)
        SHOULD_INITIALIZE=1
        echo "-h, --help                show brief help."
        echo "-t, --test                test script."
        exit 0
        ;;
    esac
done

# Creating Project
if [ $TEST_FLAG = 1 ]; then
    projectname=testproject
else
    echo "Please input your django project name."
    read projectname
fi

django-admin startproject $projectname
mv $projectname app
cp ./scripts/requirements.txt ./app/requirements.txt

head -n 16 ./app/$projectname/settings.py > ./app/$projectname/settings1.py
echo "ROOT_DIR = os.path.dirname(BASE_DIR)" >> ./app/$projectname/settings1.py
tail -n +17 ./app/$projectname/settings.py >> ./app/$projectname/settings1.py
echo "STATIC_ROOT = os.path.join(ROOT_DIR, 'static_files')" >> ./app/$projectname/settings1.py
rm ./app/$projectname/settings.py
mv ./app/$projectname/settings1.py ./app/$projectname/settings.py

if [ $TEST_FLAG = 1 ]; then
    cp ./scripts/docker-compose-wo-certbot.yml ./docker-compose.yml
    python3 scripts/generate_docker_compose_yml.py $projectname
    mkdir nginx
    cp ./scripts/nginx-wo-certbot.conf ./nginx/nginx.conf
    docker-compose build
    docker-compose config

else
    while true; do
        read -p "Do you wish to use the certbot for https? [y/n]" yn
        case $yn in
            [Yy]* ) cp ./scripts/docker-compose.yml ./docker-compose.yml;
                    python3 scripts/generate_docker_compose_yml.py $projectname
                    mkdir nginx;
                    cp ./scripts/nginx.conf ./nginx/nginx.conf;
                    sudo ./init-letsencrypt.sh; 
                    break;;

            [Nn]* ) cp ./scripts/docker-compose-wo-certbot.yml ./docker-compose.yml;
                    python3 scripts/generate_docker_compose_yml.py $projectname
                    mkdir nginx;
                    cp ./scripts/nginx-wo-certbot.conf ./nginx/nginx.conf;
                    docker-compose up --build;
                    break;;

            * ) echo "Please answer yes or no.";;
        esac
    done
fi

