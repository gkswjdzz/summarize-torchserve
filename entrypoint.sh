curl -X GET $BART_BASE_CNN_LINK -o /home/model-server/model-store/bart-base-cnn.mar
curl -X GET $BART_BASE_XSUM_LINK -o /home/model-server/model-store/bart-base-xsum.mar
curl -X GET $BART_LARGE_BASE_CNN_LINK -o /home/model-server/model-store/bart-large-base-cnn.mar
curl -X GET $BART_LARGE_BASE_XSUM_LINK -o /home/model-server/model-store/bart-large-base-xsum.mar

nginx -c /app/nginx.conf
nginx -s reload
torchserve --start --ncs --model-store=/home/model-server/model-store --models=all
streamlit run /examples/intro.py --server.enableXsrfProtection=false --server.enableCORS=true