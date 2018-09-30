import boto3
ec2 = boto3.resource('ec2')
instance = ec2.instances.filter(InstanceIds=ids)
print("instance", instance)