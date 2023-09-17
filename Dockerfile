FROM --platform=linux/amd64 python:3

WORKDIR /app
COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

COPY hello.py .

ENTRYPOINT [ "python" ]

CMD ["hello.py"]
