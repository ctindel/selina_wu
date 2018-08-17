#!/bin/bash

curl -X DELETE http://instance-1:9200/logstash-cisco-asa-*
echo ""
rm -f /tmp/fail-*.log
cat /home/elkuser/logs/* | sudo /usr/share/logstash/bin/logstash -f /home/elkuser/conf/cisco-asa-logstash.conf
