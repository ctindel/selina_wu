#!/bin/bash

curl -X DELETE http://instance-1:9200/logstash-cisco-asa-*
echo ""
rm -f /tmp/fail-*.log
#head -10 /tmp/samplelog.txt | logstash -f /usr/share/logstash/pipeline/cisco-asa-logstash.conf
cat /tmp/samplelog.txt | logstash -f /usr/share/logstash/pipeline/cisco-asa-logstash.conf
