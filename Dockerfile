# syntax=docker/dockerfile:1

FROM dorowu/ubuntu-desktop-lxde-vnc:latest

# ENV DEBIAN_FRONTEND noninteractive
ENV container docker

RUN apt-get update && apt-get install python3 python3-pip curl unzip -yf
RUN apt-get update -y
RUN apt-get install -y dbus-x11
RUN apt-get -y install libssl1.1
# INSTALL nano text editor
RUN apt-get install -y nano
# Install Chrome
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
RUN dpkg -i /chrome.deb || apt-get install -yf
RUN rm /chrome.deb
# Install Chrome Driver
RUN curl https://chromedriver.storage.googleapis.com/98.0.4758.102/chromedriver_linux64.zip -o /usr/local/bin/chromedriver.zip
RUN cd /usr/local/bin && unzip chromedriver.zip
RUN chmod +x /usr/local/bin/chromedriver
# INSTALL opencv
RUN apt-get install -y libopencv-dev python3-opencv
# INSTALL xlib xvfb xserver
RUN apt install -y python3-xlib python3-tk python3-dev
RUN apt install -y xvfb xserver-xephyr
RUN Xvfb :99 -ac &
RUN export DISPLAY=:99
# INSTALL scrot
RUN apt-get install -y scrot
# INSTALL xdotool
RUN apt-get install -y xdotool
# INSTALL pip requirements
RUN mkdir /app
COPY requirements.txt /app
RUN pip3 install -r /app/requirements.txt
