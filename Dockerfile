FROM dpokidov/imagemagick:latest-ubuntu

RUN apt update
RUN apt install -y software-properties-common libjpeg-dev libcairo2 libcairo-dev ffmpeg git wget curl

RUN add-apt-repository 'ppa:deadsnakes/ppa'
RUN apt update && apt install -y python3.10 python3.10-distutils
# python3-pip python3-setuptools
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

RUN pip3 install -U uvicorn
RUN pip3 install --pre moviepy

COPY requirements-otto.txt /
COPY requirements-alfred.txt /

RUN pip3 install -Ur /requirements-otto.txt
RUN pip3 install -Ur /requirements-alfred.txt


WORKDIR /app

ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]
