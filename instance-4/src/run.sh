#!/bin/bash

cat /srv/logs/* | logstash -f /usr/share/logstash/pipeline/cisco-asa-logstash.conf
