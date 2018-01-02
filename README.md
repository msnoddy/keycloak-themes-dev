# keycloak-themes-dev
Simple development environment for [Keycloak](http://www.keycloak.org/) themes using Docker

*tested with keycloak 3.4.2*

## Install

- Docker needs to be installed on your machine (Get it [here](https://www.docker.com/community-edition))
- Run the below command to install and run the docker enviroment:

```{shell{
git clone https://github.com/msnoddy/keycloak-themes-dev &&
cd keycloak-themes-dev &&
./run.sh
```

- The themes directory will now contain the themes for Keycloak, which the Docker environment will read from
- To access the keycloak admin panel for themes go to http://localhost:8888/auth/admin/master/console/#/realms/master/theme-settings - use the following credentials to login:
```
username: admin
password: 1Password2
```
- The script will prompt you if want to open up the themes directory Visual Studio Code, and load the Keycloak 
login screen in your browser
