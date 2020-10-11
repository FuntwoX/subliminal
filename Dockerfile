FROM python:3-alpine
MAINTAINER <https://github.com/FuntwoX>

ENV PYTHONIOENCODING="UTF-8"

RUN apk add --no-cache unrar \
	git \
	bash

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN \
 git clone -b develop https://github.com/Diaoul/subliminal.git /usr/src/app
 
# Install subliminal
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /

#Language as IETF code
ENV LANG="-l en -l fr"

#Each X minutes
ENV LOOK_TIME=5

COPY htpasswd /etc/.htpasswd

# Directory for user video files
VOLUME ["/downloads"]

COPY cronUserAndStart.sh /
COPY cron_subliminal_user /

RUN chmod +x cronUserAndStart.sh

CMD ["/cronUserAndStart.sh", "/etc/.htpasswd"]