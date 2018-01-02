FROM jboss/keycloak
RUN /opt/jboss/keycloak/bin/add-user-keycloak.sh -u admin -p password

# turn off caching for themes
RUN sed -i -e 's#<staticMaxAge>.*</staticMaxAge>#<staticMaxAge>-1</staticMaxAge>#g' /opt/jboss/keycloak/standalone/configuration/standalone.xml
RUN sed -i -e 's#<cacheThemes>.*</cacheThemes>#<cacheThemes>false</cacheThemes>#g' /opt/jboss/keycloak/standalone/configuration/standalone.xml
RUN sed -i -e 's#<cacheTemplates>.*</cacheTemplates>#<cacheTemplates>false</cacheTemplates>#g' /opt/jboss/keycloak/standalone/configuration/standalone.xml

EXPOSE 8080 8888
