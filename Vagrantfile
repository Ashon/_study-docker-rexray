#!/bin/env ruby

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'dummy'

  # Local Environments
  test_node_key_path = ENV['AWS_EC2_PRIVATE_KEY_PATH']

  # AWS Environments
  AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID']
  AWS_SECRET_ACCESS_KEY = ENV['AWS_SECRET_ACCESS_KEY']

  # test node contants
  test_node_count = 2
  test_node_ami = 'ami-66e33108'
  test_node_type = 't2.medium'
  test_node_region = 'ap-northeast-2'
  test_node_keypair_name = 'provision'
  test_node_security_groups = ['default']

  (1..test_node_count).each do |i|
    config.vm.define "aws-test-node-#{i}" do |instance|
      instance.vm.provider :aws do |aws, override|
        aws.tags = {
          'Name' => "aws-test-node-#{i}"
        }

        aws.access_key_id = AWS_ACCESS_KEY_ID
        aws.secret_access_key = AWS_SECRET_ACCESS_KEY
        aws.keypair_name = test_node_keypair_name

        aws.ami = test_node_ami
        aws.instance_type = test_node_type
        aws.region = test_node_region
        aws.security_groups = test_node_security_groups

        override.ssh.username = 'ubuntu'
        override.ssh.private_key_path = test_node_key_path
        override.ssh.pty = false
        override.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

        override.vm.provision "shell",
          inline: "sudo apt-get update && sudo apt-get install -y python aptitude"

        if i == test_node_count
          override.vm.provision "ansible" do |ansible|
            ansible.groups = {
              "testnode" => ["aws-test-node-[1:#{test_node_count}]"]
            }
            ansible.limit = "testnode"
            ansible.playbook = './ansible/infrastructure.yml'
            ansible.extra_vars = {
              ebs_access_key: AWS_ACCESS_KEY_ID,
              ebs_secret_key: AWS_SECRET_ACCESS_KEY,
              ebs_region: test_node_region
            }
          end
        end
      end
    end
  end
end

