#Subsonic StandAlone Docker Image
FROM ubuntu:16.04
RUN echo "Subsonic StandAlone Docker Image With FFMPEG (v6.0)"
RUN locale-gen en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install ffmpeg libav-tools openjdk-8-jre-headless nano flac lame wget -y
RUN mkdir -p /opt/subsonic
RUN wget -qO- https://s3-eu-west-1.amazonaws.com/subsonic-public/download/subsonic-6.1.beta1-standalone.tar.gz | tar xvz -C /opt/subsonic
ENV LANG en_US.UTF-8 ENV LC_ALL en_US.UTF-8 
VOLUME ["/var/music", "/var/subsonic"]
CMD /bin/bash -c "export LANG=en_US.UTF-8 && /opt/subsonic/subsonic.sh && /bin/bash"
RUN mkdir -p /var/subsonic/transcode && \
cd /var/subsonic/transcode && \
ln -s "$(which ffmpeg)"
EXPOSE 4040
