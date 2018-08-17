# Setup config files and install utilities

```
sudo bash /home/elkuser/setup.sh
```

# Install ELK stack

1.  Install elasticsearch on instance-{1,2,3}
  *.  yum install -y elasticsearch
  *.  Copy elasticsearch.yml to /etc/elasticsearch
  *.  systemctl enable elasticsearch
  *.  systemctl start elasticsearch
  *.  tail -f /var/log/elasticsearch/selina_wu.log

2.  Install kibana on instance-5
  *.  yum install -y kibana
  *.  Copy kibana.yml to /etc/kibana
  *.  systemctl enable kibana
  *.  systemctl start kibana
  *.  journalctl -f -u kibana

3.  Install logstash on instance-4
  *.  yum install -y logstash
  *.  Copy logstash files to /home/elkuser
  *.  Run /home/elkuser/test.sh which will delete the logstash-cisco-asa-\*
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
