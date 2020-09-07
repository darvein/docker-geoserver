FROM  tomcat:9-jdk8

LABEL maintainer="darvein@gmail.com"

# Geoserver setup
ENV GEOSERVER_VER=2.17.2
ENV TOMCAT_HOME=/usr/local/tomcat
ENV GEOSERVER_HOME=$TOMCAT_HOME/webapps/geoserver
ENV GEOSERVER_DATA_DIR=/var/temp/geoserver-data
ENV ARTIFACT_URL="http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VER}/geoserver-${GEOSERVER_VER}-war.zip"

# Plugins
ENV PLUGIN_IMPORT=https://sourceforge.net/projects/geoserver/files/GeoServer/2.17.0/extensions/geoserver-2.17.0-importer-plugin.zip/download

# Tomcat config
ENV CATALINA_OPTS "-server -Djava.awt.headless=true \
	    -Xms768m -Xmx1560m -XX:+UseConcMarkSweepGC -XX:NewSize=48m \
	    -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"

# Geoserver installation
RUN wget $ARTIFACT_URL -O /var/tmp/geoserver.zip \
	    && wget $PLUGIN_IMPORT -O /var/tmp/import_plugin.zip \
	    && echo "[INFO] Uncompressing downloaded files" \
	    && mkdir -p $GEOSERVER_HOME \
	    && unzip /var/tmp/geoserver.zip -d /var/tmp/geoserver \
	    && unzip /var/tmp/geoserver/geoserver.war -d $GEOSERVER_HOME \
	    && unzip -f /var/tmp/import_plugin.zip -d $GEOSERVER_HOME/WEB-INF/lib \
	    && echo "[INFO] Cleaning" \
	    && rm -rf /var/tmp/geoserver \
	    && rm -rf /var/tmp/geoserver.zip \
	    && rm -rf /var/tmp/import_plugin.zip

COPY rootfs /
