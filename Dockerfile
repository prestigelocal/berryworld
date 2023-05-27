# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Update and install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y lib32gcc1 curl net-tools lib32stdc++6 locales

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add user for SteamCMD
RUN useradd -m steam
WORKDIR /home/steam

# Download SteamCMD
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Switch to user steam
USER steam

# Expose necessary ports
EXPOSE 27015 27015/udp

# Start server
RUN ./steamcmd.sh +login ${STEAM_USERNAME} ${STEAM_PASSWORD} ${STEAM_GUARD_CODE} +force_install_dir ./berryworld -applaunch 663670 --start-server 5000 --spectator -batchmode -nographics
