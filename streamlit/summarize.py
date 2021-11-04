import streamlit as st
import json
import requests

models = {
    'cnn 데이터셋으로 학습한 bart model': 'bart-base-cnn',
    'xsum 데이터셋으로 학습한 bart model': 'bart-base-xsum',
    'cnn 데이터셋으로 학습한 bart large model': 'bart-large-base-cnn',
    'xsum 데이터셋으로 학습한 bart large': 'bart-large-base-xsum',
    '한국어 뉴스 데이터셋으로 학습한 kobart': 'kobart',
}


def process():
    data = {
        'text': text,
        'max_length': max_length,
    }
    res = requests.post('http://localhost/api/' + model_value, data=json.dumps(data), headers={"Content-Type": "application/json"})
    return res


FAVICON_URL = "https://ainize.ai/images/github-ainize-box@2x.png"

# Set page title and favicon.
st.set_page_config(
    page_title="요약해보세요!", page_icon=FAVICON_URL,
)

st.title("teachable NLP로 학습한 모델로 요약해보자!")

st.subheader("모델을 선택하고 문장을 작성해주세요.")

model = st.selectbox('선택', list(models.keys()))
model_value = models[model]
text = st.text_input("요약하고 싶은 문장을 적어주세요.")
max_length = st.slider('max length', 10, 500, 140, 10)

if st.button("요약하기"):
    sts = process()
    res = sts.json()
    st.write("")
    st.write(res[0])
