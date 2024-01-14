#   -------------------------------------------------------------
#   Nasqueron - Airflow Docker image for Nasqueron Datasources
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   License:        BSD-2-Clause
#   -------------------------------------------------------------

#    -------------------------------------------------------------
#    Datasources image
#    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

FROM nasqueron/datasources AS datasources

#    -------------------------------------------------------------
#     Release phase
#    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

FROM apache/airflow:2.8.0-python3.11

USER root
COPY files/nasqueron-vault-ca.crt /usr/local/share/ca-certificates/nasqueron-vault-ca.crt
RUN /usr/sbin/update-ca-certificates

RUN apt update && \
    apt install -y unzip libpq5 && \
    rm -r /var/lib/apt/lists/*

COPY --from=datasources /usr/local/bin/fantoir-datasource /usr/local/bin/

USER airflow
RUN pip install 'apache-airflow[sentry]'

ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs
