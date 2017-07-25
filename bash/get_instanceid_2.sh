#!/bin/bash
aws ec2 describe-instances --filter Name=private-dns-name,Values="`hostname --long`" --query Reservations[].Instances[].InstanceId --output text
