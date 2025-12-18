FROM python:3.10-slim
RUN mkdir arjun
WORKDIR /arjun
COPY . /arjun
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python3", "app.py"]
