#!/bin/sh

echo "📦 Running migrations..."
python manage.py migrate --noinput

echo "🧹 Collecting static files..."
python manage.py collectstatic --noinput

echo "🚀 Starting Gunicorn server on port 8000..."
gunicorn job.wsgi:application --bind 0.0.0.0:8000
