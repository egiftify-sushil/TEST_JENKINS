now=$(date +"%Y%m%d")Z.${RANDOM};
zip -r  /home/ec2-user/apollo1_logs_$now.zip $(find /var/log/fluent/web -type f -mtime +1)
aws s3 cp  /home/ec2-user/apollo1_logs_$now.zip s3://egprod-server-logs/apollo/
rm -rf /home/ec2-user/apollo1_logs_$now.zip
sudo service td-agent-bit stop
rm -rf  $(find /var/log/fluent/web -type f -mtime +1)
sudo service td-agent-bit start


now=apollo1_logs_$(date +"%Y%m%d")Z.${RANDOM};
zip -r  /home/ec2-user/$now.zip $(find /var/log/fluent/web -type f -mtime +1)
aws s3 cp  /home/ec2-user/$now.zip s3://egprod-server-logs/apollo/
rm -rf /home/ec2-user/$now.zip
sudo service td-agent-bit stop
rm -rf  $(find /var/log/fluent/web -type f -mtime +1)
sudo service td-agent-bit start

now=mariner2_logs_$(date +"%Y%m%d")Z.${RANDOM};
zip -r  /home/ec2-user/$now.zip $(find /var/log/fluent/api -type f -mtime +1)
aws s3 cp  /home/ec2-user/$now.zip s3://egprod-server-logs/mariner/
rm -rf /home/ec2-user/$now.zip
sudo service td-agent-bit stop
rm -rf  $(find /var/log/fluent/api -type f -mtime +1)
sudo service td-agent-bit start

// After 7 days
0 5 */7 * * /var/devops/cron/upload-fluentlog-s3.sh >> /var/devops/cron/s3log.log 2>&1

*/5  * * * * /var/devops/cron/upload-fluentlog-s3.sh >> /var/devops/cron/s3log.log 2>&1


