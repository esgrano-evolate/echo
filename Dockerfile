FROM --platform=linux/amd64 python:3

WORKDIR /app
COPY requirements.txt ./
COPY hello.py .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

ENTRYPOINT [ "python" ]

CMD ["hello.py"]
