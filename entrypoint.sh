curl -X GET $BART_BASE_CNN_LINK -o /home/model-server/model-store/bart-base-cnn.mar
curl -X GET $BART_BASE_XSUM_LINK -o /home/model-server/model-store/bart-base-xsum.mar
curl -X GET $BART_LARGE_BASE_CNN_LINK -o /home/model-server/model-store/bart-large-base-cnn.mar
curl -X GET $BART_LARGE_BASE_XSUM_LINK -o /home/model-server/model-store/bart-large-base-xsum.mar
curl -X GET $KOBART_LINK -o /home/model-server/model-store/kobart.mar

nginx -c /app/nginx.conf
nginx -s reload
torchserve --start --ncs --model-store=/home/model-server/model-store --ts-config /home/model-server/config.properties
sleep 10
ls /home/model-server/model-store > model_list.txt
cat model_list.txt | xargs -I {} curl -X POST http://localhost:8081/models?url={}
streamlit run /streamlit/summarize.py --server.enableXsrfProtection=false --server.enableCORS=true