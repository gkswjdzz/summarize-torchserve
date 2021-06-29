import streamlit as st
import json
import requests

models = {
    'bart model with cnn dataset': 'bart-base-cnn',
    'bart model with xsum dataset': 'bart-base-xsum',
    'bart large model with cnn dataset': 'bart-large-base-cnn',
    'bart large with xsum dataset': 'bart-large-base-xsum',
    'kobart with korean news dataset (Korean)': 'kobart',
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
    page_title="Summarize!", page_icon=FAVICON_URL,
)

st.title("Summarize with teachable NLP!")

st.subheader("Select model and write sentence.")

model = st.selectbox('Select', list(models.keys()))
model_value = models[model]
text = st.text_input("Write the sentence you want to summarize!")
max_length = st.slider('max length', 10, 500, 140, 10)

if st.button("Summarize!"):
    sts = process()
    res = sts.json()
    st.write("")
    st.write(res[0])
