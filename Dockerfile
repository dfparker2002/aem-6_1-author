# DOCKER-VERSION 1.7.0 AUTHOR
FROM dbenge/aem-6-1-base
LABEL version="1.0"
LABEL description="AEM author docker image"
MAINTAINER dbenge

#Copies required build media
ADD resources/*.jar /aem/cq-author-4502.jar
ADD resources/license.properties /aem/license.properties

# Extracts AEM
WORKDIR /aem
RUN java -XX:MaxPermSize=256m -Xmx1024M -jar cq-author-4502.jar -unpack -r nosamplecontent

# Add customised log file, to print the logging to standard out.
ADD resources/org.apache.sling.commons.log.LogManager.config /aem/crx-quickstart/install

# Installs AEM
RUN ["python","aemInstaller.py","-i","cq-author-4502.jar","-r","author","-p","4502"]

EXPOSE 4502
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]