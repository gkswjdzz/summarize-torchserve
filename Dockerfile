FROM pytorch/torchserve:0.4.0-gpu

USER root

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt update \
  && apt install -y nginx curl \
  && rm -rf /var/lib/apt/lists/*

RUN echo default_workers_per_model=1 >> /home/model-server/config.properties

WORKDIR /app
COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY nginx.conf .
COPY streamlit /examples

ARG BART_BASE_CNN_LINK
ENV BART_BASE_CNN_LINK $BART_BASE_CNN_LINK

ARG BART_BASE_XSUM_LINK
ENV BART_BASE_XSUM_LINK $BART_BASE_XSUM_LINK

ARG BART_LARGE_BASE_CNN_LINK
ENV BART_LARGE_BASE_CNN_LINK $BART_LARGE_BASE_CNN_LINK

ARG BART_LARGE_BASE_XSUM_LINK
ENV BART_LARGE_BASE_XSUM_LINK $BART_LARGE_BASE_XSUM_LINK

COPY entrypoint.sh .
EXPOSE 80

ENTRYPOINT [ "bash", "entrypoint.sh" ]
