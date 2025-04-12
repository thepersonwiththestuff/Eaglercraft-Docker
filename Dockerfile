# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Pacific/Los_Angeles
ENV LC_ALL=C

# Install dependencies
RUN apt-get update && \
    apt-get --no-install-recommends -y upgrade && \
    apt-get --no-install-recommends -y install \
    bash openjdk-8-jre sudo curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set shell for running commands
SHELL [ "/bin/bash", "-c" ]

# Set the working directory for your server
WORKDIR /bukkit

# Copy the necessary files
ADD server/bukkit /server/bukkit
COPY run.sh /run.sh

# Make sure run.sh is executable
RUN chmod +x /run.sh

# Expose the port
EXPOSE 25569

# Run the server when the container starts
CMD [ "/bin/bash", "-c", "/usr/bin/cp -r /server/bukkit/* /bukkit && /usr/bin/java -Xmx512M -Xms512M -jar craftbukkit-1.5.2-R1.0.jar nogui" ]
