FROM python:3.7
 

WORKDIR /app
COPY app /app
#RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 3000

CMD ["python","main.py"] 