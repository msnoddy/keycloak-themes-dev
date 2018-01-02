yesNoOptions=("y", "n")

function openKeycloakInBrowser
{
    echo "Opening keycloak login in browser..."
    open http://localhost:8888/auth/admin/
}

function openThemesInVsCode
{
    if [ "$(command -v code)" != "" ]; then
        echo "Opening themes directory in vscode..."
        open -a Visual\ Studio\ Code $DIR/themes
    fi
}

function main
{
    echo "Cleaning up old docker keycloak containers..."

    docker image prune -f > /dev/null
    docker stop $(docker ps -aqf "ancestor=keycloak-theme-dev" 2> /dev/null) > /dev/null
    docker rm $(docker ps -aqf "ancestor=keycloak-theme-dev" 2> /dev/null) > /dev/null

    if [ -d themes ]; then
        echo "Archiving old themes directory..."

        DATE_WITH_TIME=`date "+%Y%m%d-%H%M%S"`
        FOLDER_NAME="themes_$DATE_WITH_TIME"

        mv themes $FOLDER_NAME

        echo "Old themes directory is now: $FOLDER_NAME"
    fi

    echo "Unpacking default keycloak themes..."
    unzip themes.zip -d themes > /dev/null

    echo "Building and running keycloak docker container..."
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    docker build . -t keycloak-theme-dev > /dev/null
    docker run -d -v $DIR/themes:/opt/jboss/keycloak/themes -p=8888:8080 keycloak-theme-dev > /dev/null

    printf "Waiting for keycloak to become available..."

    while ! curl --output /dev/null --silent --head --fail http://localhost:8888; do 
        sleep 1 && printf . 
    done;

    echo
    echo "Open keycloak login page in browser? [y/n] "
    select anwser in "${yesNoOptions[@]}"; do
        case "$REPLY" in
            "y") openKeycloakInBrowser; break;;
            "Y") openKeycloakInBrowser; break;;
            *) echo "invalid";;
        esac
    done
    echo

    echo
    echo "Open themes directory in VsCode? [y/n] "
    select anwser in "${yesNoOptions[@]}"; do
        case "$REPLY" in
            "y") openThemesInVsCode; break;;
            "Y") openThemesInVsCode; break;;
            *) echo "invalid";;
        esac
    done
    echo

    echo "done!"
}

main
