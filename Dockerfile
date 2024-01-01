FROM nvidia/cuda:12.3.1-base-ubuntu22.04
RUN apt-get update -y && apt-get upgrade -y && apt-get install gcc git vim time wget python3-pip python3-dev unzip -y --no-install-recommends

# Solves missing Error: libcublasLt.so.11: cannot open shared object file: No such file or directory
RUN apt-get install libcudnn8=8.8.1.3-1+cuda11.8 libcublas-11-8 -y 

# Whisper
COPY requirements.txt /srv/
RUN pip install -r /srv/requirements.txt
RUN python3 -c 'from faster_whisper import WhisperModel;  WhisperModel("medium")'

COPY entry-point.sh /srv/
COPY data/* /srv/

# Translation
ENV URL https://www.softcatala.org/pub/softcatala/opennmt/models/2022-11-22
ENV FILE cat-eng-2023-10-29.zip
WORKDIR /srv/
RUN wget -q $URL/$FILE && unzip $FILE -x */tensorflow/* && rm *.zip

RUN git clone https://github.com/Softcatala/nmt-softcatala 
RUN cd nmt-softcatala/ && git checkout batch_txt
WORKDIR nmt-softcatala/use-models-tools/
RUN pip install . && rm -r -f nmt-softcatala/use-models-tools/

ENTRYPOINT /srv/entry-point.sh

