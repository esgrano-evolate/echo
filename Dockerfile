FROM --platform=linux/amd64 python:3

WORKDIR /app
COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

COPY echo.py .

ENTRYPOINT [ "python" ]

CMD ["echo.py"]
