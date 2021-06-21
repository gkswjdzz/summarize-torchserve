FROM pytorch/torchserve:0.4.0-gpu

USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN pip install transformers

RUN echo default_workers_per_model=1 >> config.properties

USER model-server
WORKDIR /home/model-server

ARG BART_BASE_CNN_LINK
ENV BART_BASE_CNN_LINK $BART_BASE_CNN_LINK

ARG BART_BASE_XSUM_LINK
ENV BART_BASE_XSUM_LINK $BART_BASE_XSUM_LINK

ARG BART_LARGE_BASE_CNN_LINK
ENV BART_LARGE_BASE_CNN_LINK $BART_LARGE_BASE_CNN_LINK

ARG BART_LARGE_BASE_XSUM_LINK
ENV BART_LARGE_BASE_XSUM_LINK $BART_LARGE_BASE_XSUM_LINK

COPY entrypoint.sh .
EXPOSE 8000

CMD ["bash", "./entrypoint.sh"]
