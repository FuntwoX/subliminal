FROM lsiobase/alpine.python
MAINTAINER <https://github.com/FuntwoX>

ENV PYTHONIOENCODING="UTF-8"

# Install subliminal
RUN pip install subliminal

#Language as IETF code
ENV LANG="-l en -l fr"

#Each X minutes
ENV LOOK_TIME=5

COPY htpasswd /etc/.htpasswd

# Directory for user video files
VOLUME ["/download"]

COPY cronUserAndStart.sh /
COPY cron_subliminal_user /

RUN chmod +x cronUserAndStart.sh
CMD ["/cronUserAndStart.sh", "/etc/.htpasswd"]