FROM lsiobase/alpine.python
MAINTAINER <https://github.com/FuntwoX>

ENV PYTHONIOENCODING="UTF-8"

# Install subliminal
RUN pip install subliminal

#Language as IETF code
ENV LANG="-l en -l fr"

#Each X minutes
ENV LOOK_TIME=5

#cronjob creation
RUN mkdir -p /etc/periodic/${LOOK_TIME}min
COPY cron_subliminal.sh /etc/periodic/${LOOK_TIME}min/cron_subliminal
RUN chmod -R +x /etc/periodic/
RUN crontab -l | { cat; echo "*/${LOOK_TIME}     *       *       *       *       run-parts /etc/periodic/${LOOK_TIME}min"; } | crontab -

# Directory for video files
VOLUME ["/home/video"]

CMD ["crond", "-f", "-d", "8"]
