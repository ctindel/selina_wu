# Setup config files and install utilities

```
sudo bash /home/elkuser/setup.sh
```

# Install ELK stack

1.  Install elasticsearch on instance-{1,2,3}
  1.  yum install -y elasticsearch
  2.  Copy elasticsearch.yml to /etc/elasticsearch
  3.  systemctl enable elasticsearch
  4.  systemctl start elasticsearch
  5.  tail -f /var/log/elasticsearch/selina_wu.log

2.  Install kibana on instance-5
  1.  yum install -y kibana
  2.  Copy kibana.yml to /etc/kibana
  3.  systemctl enable kibana
  4.  systemctl start kibana
  5.  journalctl -f -u kibana

3.  Install logstash on instance-4
  1.  yum install -y logstash
  2.  Copy logstash files to /home/elkuser
  3.  Run /home/elkuser/test.sh which will delete the logstash-cisco-asa-\*
indices and run logstash to process all the files in /home/elkuser/logs which
in this case is just the sample.

# Querying Data

1.  Indices will be named logstash-cisco-asa-YYYY.MM.dd

You really want to follow this format as logstash loads index templates for
logstash-\* indices only, and that date format is the standard date format 
used in all the ES docs, examples, and other tools.

1.  From Kibana Dev Tools you can run ES queries like:

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
