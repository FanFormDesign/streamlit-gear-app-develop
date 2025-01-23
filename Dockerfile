FROM python:3.10-slim-bullseye

WORKDIR /app
COPY . /app

RUN apt-get update && \
    apt-get install -y \
    libgl1-mesa-glx \
    libgomp1 \
    libglu1-mesa \
    libxrender1 \
    libxext6 \
    xvfb \
    python3-tk \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8501

ENV STREAMLIT_SERVER_RUN_ON_SAVE=true
ENV STREAMLIT_SERVER_FILE_WATCHER_TYPE=auto

CMD ["streamlit", "run", "gear_model.py", "--server.port=8501", "--server.address=0.0.0.0", "--server.runOnSave=true"]