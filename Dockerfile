FROM jenkins/jnlp-slave
MAINTAINER Giannicola Olivadoti <go@empatica.com>

USER root

RUN apt-get update && \
    apt-get -y install build-essential tree && \
    rm -rf /var/lib/apt/lists/*

ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 4.1

ARG GRADLE_DOWNLOAD_SHA256=d55dfa9cfb5a3da86a1c9e75bb0b9507f9a8c8c100793ccec7beb6e259f9ed43

RUN curl -fsSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o gradle.zip && \
    echo "${GRADLE_DOWNLOAD_SHA256} gradle.zip" | sha256sum --check - && \
    unzip gradle.zip && \
    rm gradle.zip && \
    mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" && \
    ln -s "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle

ENV ANT_HOME /usr/share/ant
ENV ANT_VERSION 1.10.1

ARG ANT_DOWNLOAD_SHA256=0acf6f46a71985912f9c2c768795b97e5c26bc9a7a0b61d27af8287f8b96cd8e

RUN curl -fsSL "https://www.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.zip" -o ant.zip && \
    echo "${ANT_DOWNLOAD_SHA256} ant.zip" | sha256sum --check - && \
    unzip ant.zip && \
    rm ant.zip && \
    mv "apache-ant-${ANT_VERSION}" "${ANT_HOME}/" && \
    ln -s "${ANT_HOME}/bin/ant" /usr/bin/ant

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_VERSION 3.5.0

ARG MAVEN_DOWNLOAD_SHA256=a6866b0a0dd5abe3a51124a758a0a842a24edd0bea42ebc74dbf93ad44eb1960

RUN curl -fsSL "http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip" -o maven.zip && \
    echo "${MAVEN_DOWNLOAD_SHA256} maven.zip" | sha256sum --check - && \
    unzip maven.zip && \
    rm maven.zip && \
    mv "apache-maven-${MAVEN_VERSION}" "${MAVEN_HOME}/" && \
    ln -s "${MAVEN_HOME}/bin/mvn" /usr/bin/mvn

USER jenkins

VOLUME "/home/jenkins/.gradle"
