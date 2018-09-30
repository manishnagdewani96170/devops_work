#/usr/bin/python

#Terminate Instance
import boto
from boto import ec2
connection = ec2.connect_to_region('us-west-2')
print("connection", connection);
reservations=connection.get_all_instances();
connection.terminate_instances(instance_ids=['i-0f8c91f3565462bd0'])


