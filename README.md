# Docker REX-Ray Vagrant Example
infrastructure example code for docker rex-ray volumedriver

# Requirements
- Ansible
- Private key file for AWS EC2
- Vagrant plugins
``` sh
$ ./scripts/bootstrap.sh
```

# Test

1. Set Environment variables

``` sh
export AWS_EC2_PRIVATE_KEY_PATH="~/.ssh/my-ec2-private-key"
export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"
```

2. Create VM

``` sh
$ vagrant up

# 2 ec2 instances will up
```

3. Run nginx docker on `aws-test-node-1`

``` sh
$ ansible-playbook ansible/nginx-node1.yml
```

4. Check rexray docker volumes

``` sh
$ ansible all -m shell -a "sudo docker volume ls"
```

5. Stop node1 nginx

``` sh
$ ansible all -l aws-test-node-1 -m shell -a "sudo docker stop nginx"
```

6. Run nginx docker on `aws-test-node-2`

``` sh
$ ansible-playbook ansible/nginx-node2.yml
```

