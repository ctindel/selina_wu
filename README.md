# Setup config files and install utilities

```
sudo bash /home/elkuser/setup.sh
```

# Install ELK stack

## Install elasticsearch on instance-{1,2,3}
1. yum install -y elasticsearch
1. Copy elasticsearch.yml to /etc/elasticsearch
1. systemctl enable elasticsearch
1. systemctl start elasticsearch
1. tail -f /var/log/elasticsearch/selina_wu.log

## Install kibana on instance-5
1. yum install -y kibana
1. Copy kibana.yml to /etc/kibana
1. systemctl enable kibana
1. systemctl start kibana
1. journalctl -f -u kibana

## Install logstash on instance-4
1. yum install -y logstash
1. Copy logstash files to /home/elkuser
1. Run /home/elkuser/test.sh which will delete the logstash-cisco-asa-\*
indices and run logstash to process all the files in /home/elkuser/logs which
in this case is just the sample.

# Querying Data

Indices will be named logstash-cisco-asa-YYYY.MM.dd

You really want to follow this format as logstash loads index templates for
logstash-\* indices only, and that date format is the standard date format 
used in all the ES docs, examples, and other tools.

From Kibana Dev Tools you can run ES queries like:

```
GET _cat/nodes
GET _cat/indices
GET logstash-cisco-asa-*/_search
```

# Setup Kibana Index Patterns

The index patterns are what will show up under Discover or Dashboards.  There
aren't any setup by default so we need to create the logstash patterns.

Go to Kibana->Management->Index Patterns to create a new default index pattern
Pattern name: logstash-cisco-asa-\*

Time Filter Field Name: @timestamp
