# Use an official Python runtime as a base image
FROM python:3.9-slim

# Install the necessary system dependencies for PostgreSQL and build tools
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

#Set environment variables for Django
ENV PYTHONUNBUFFERED=1
ENV CORS_ALLOW_ALL_ORIGINS=true

# Set workdir
WORKDIR /app

# Copy the Django project files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Run migrations and start the server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
