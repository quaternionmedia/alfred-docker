FROM dpokidov/imagemagick:latest

RUN apt update
RUN apt install -y python3 python3-pip python3-setuptools
RUN apt install -y ffmpeg git wget
RUN apt install -y libjpeg-dev libcairo2 libcairo-dev

RUN pip3 install -U pip
RUN pip3 install --pre moviepy

COPY requirements.txt /requirements.txt

RUN pip3 install -Ur /requirements.txt

WORKDIR /app

ENTRYPOINT ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]
