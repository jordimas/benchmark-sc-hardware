FROM nvidia/cuda:12.3.1-base-ubuntu22.04
RUN apt-get update -y && apt-get upgrade -y && apt-get install gcc git vim time wget python3-pip python3-dev unzip -y --no-install-recommends

# Solves missing Error: libcublasLt.so.11: cannot open shared object file: No such file or directory
RUN apt-get install libcudnn8=8.8.1.3-1+cuda11.8 
RUN apt-get install libcublas-11-8 -y 

# Whisper

COPY requirements.txt /srv/

RUN pip install -r /srv/requirements.txt --no-cache-dir 
RUN python3 -c 'from faster_whisper import WhisperModel;  WhisperModel("medium")'

ARG HF_TOKEN
RUN python3 -c 'from pyannote.audio import Pipeline; import os; Pipeline.from_pretrained("pyannote/speaker-diarization-3.1",use_auth_token=os.environ["HF_TOKEN"])'

COPY entry-point.sh /srv/
COPY data/* /srv/
ENV HF_TOKEN=$HF_TOKEN
ENTRYPOINT /srv/entry-point.sh 

