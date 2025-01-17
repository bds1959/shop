FROM tomcat:8.5.40-jre8
MAINTAINER Murali Krishna Reddy

VOLUME /tmp

# Diagnose and analyze potential db connection issue and log files
RUN apt-get update && apt-get install -y mysql-client
RUN apt-get update && apt-get install -y vim

# Delete existing ROOT folder
RUN rm -rf /usr/local/tomcat/webapps/ROOT

RUN mkdir -p /usr/local/tomcat/files

ADD ./sm-shop/target/*.war /usr/local/tomcat/webapps/
ADD ./sm-shop/SALESMANAGER.h2.db /usr/local/tomcat/
COPY ./sm-shop/files/ /usr/local/tomcat/files/
RUN ls -la /usr/local/tomcat/files/*

ENV JAVA_OPTS="-Xmx1024m"

CMD ["catalina.sh", "run"]

EXPOSE 8080
