# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Pacific/Los_Angeles
ENV LC_ALL=C

RUN apt-get update && \
    apt-get --no-install-recommends -y upgrade && \
    apt-get --no-install-recommends -y install \
    bash openjdk-8-jre sudo curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

SHELL [ "/bin/bash", "-c" ]

ADD server/bukkit /server/bukkit

EXPOSE 25569

WORKDIR /bukkit

RUN mkdir -p /bukkit

# VOLUME "/bukkit"

CMD [ "/bin/bash", "-c", "/usr/bin/cp -r /server/bukkit/* /bukkit && /usr/bin/java -Xmx512M -Xms512M -jar craftbukkit-1.5.2-R1.0.jar nogui" ]
