FROM adoptopenjdk/openjdk11-openj9:alpine-jre

LABEL org.opencontainers.image.source https://github.com/${GH_OWNER}/${ARTIFACT_ID}

# Configurations
WORKDIR /opt/slingcms
ARG FEATURE_LAUNCHER_VERSION=1.1.16

# Setup the Composite nodestore
RUN apk add curl
RUN curl -L https://search.maven.org/remotecontent?filepath=org/apache/sling/org.apache.sling.feature.launcher/1.1.16/org.apache.sling.feature.launcher-${FEATURE_LAUNCHER_VERSION}.jar \
    --output /opt/slingcms/org.apache.sling.feature.launcher.jar
COPY slingcms/setup/ /opt/slingcms/setup/
RUN /bin/sh /opt/slingcms/setup/setup-composite.sh

# upload the runtime features
COPY runtime/ /opt/slingcms/

# Expose endpoints
EXPOSE 8080

# Start Sling CMS
CMD exec java -jar org.apache.sling.feature.launcher.jar -f /run/secrets/cms-creds -f *.far -f *.json
