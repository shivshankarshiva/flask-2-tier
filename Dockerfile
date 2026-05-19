FROM python:3.9-slim

WORKDIR /app

# System deps (keep only runtime essentials)
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-libmysqlclient-dev \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies first (better caching)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy app last
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
