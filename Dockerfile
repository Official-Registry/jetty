FROM quay.io/lizhongwen/oracle-jdk:1.8

MAINTAINER github.com/Official-Registry, lizhongwen1989@gmail.com

#
# http://www.eclipse.org/jetty/download.html
#

ENV JETTY_VERSION=9.3.11.v20160721
ENV JETTY_HOME=/opt/app/jetty
ENV JAVA_DEBUG=false
ENV JVM_MIN_MEM=256
ENV JVM_MAX_MEM=1024

EXPOSE 8080 8888

RUN curl --fail --location --retry 3 \
  http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.3.11.v20160721/jetty-distribution-9.3.11.v20160721.tar.gz \
  -o /tmp/jetty.tar.gz \
  && tar -zvxf /tmp/jetty.tar.gz -C /tmp/ \
  && mkdir -p /opt/app/ \
  && mv /tmp/jetty-distribution-${JETTY_VERSSION} ${JETTY_HOME} \
  && rm -rf /tmp/jetty.tar.gz ${JETTY_HOME}/demo-base

ADD resources/entrypoint.sh ${JETTY_HOME}/bin/

RUN chmod +x ${JETTY_HOME}/bin/entrypoint.sh \
  && apt-get install -y unzip

ENTRYPOINT ["/bin/sh", "-c", "${JETTY_HOME}/bin/entrypoint.sh"]
