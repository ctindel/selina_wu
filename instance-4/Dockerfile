FROM docker.elastic.co/logstash/logstash:6.3.2
MAINTAINER Solution Architects "sa@elastic.co"

COPY src /tmp/src
COPY samplelog.txt /tmp

USER root

RUN yum -y install epel-release && yum -y update && \
    yum -y install vim nmap-ncat curl awscli jq

RUN rm -f /usr/share/logstash/pipeline/logstash.conf && \
    rm -f /usr/share/logstash/config/logstash.yml && \
    chmod 755 /tmp/src/loop.sh /tmp/src/test.sh

ADD pipeline/ /usr/share/logstash/pipeline/
ADD patterns/ /usr/share/logstash/cisco-grok-patterns/

RUN echo "http.host: \"0.0.0.0\"" > /usr/share/logstash/config/logstash.yml && \
    echo "node.name: instance-4" >> /usr/share/logstash/config/logstash.yml && \
    echo "path.config: /usr/share/logstash/pipeline" >> /usr/share/logstash/config/logstash.yml && \
    echo "xpack.monitoring.enabled: false" >> /usr/share/logstash/config/logstash.yml
    #echo "xpack.monitoring.elasticsearch.url: [\"http://instance-1:9200\", \"http://instance-2:9200\", \"http://instance-3:9200\"]" >> /usr/share/logstash/config/logstash.yml

CMD ["/tmp/src/loop.sh"]
