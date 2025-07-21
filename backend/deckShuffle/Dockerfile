FROM eclipse-temurin:21-jdk
RUN apt-get update && apt-get install -y python3 && apt-get install -y python3-venv
WORKDIR /app
COPY python/requirements.txt .
RUN python3 -m venv venv && \
    venv/bin/pip install --upgrade pip && \
    venv/bin/pip install --no-cache-dir -r requirements.txt
COPY python/ ./python
ENV PYTHONPATH="/app/python"
COPY target/*.jar app.jar
ENTRYPOINT ["sh", "-c", "cd ./python/model/learning && /app/venv/bin/python ./learn_script.py && cd /app && java -jar app.jar"]
