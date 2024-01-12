FROM apache/airflow:2.8.0-python3.11

USER root
COPY files/nasqueron-vault-ca.crt /usr/local/share/ca-certificates/nasqueron-vault-ca.crt
RUN /usr/sbin/update-ca-certificates

USER airflow
RUN pip install 'apache-airflow[sentry]'

ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs
