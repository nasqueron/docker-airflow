FROM apache/airflow:2.8.0-python3.11

RUN pip install 'apache-airflow[sentry]'
