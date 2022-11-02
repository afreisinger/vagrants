#
Vagrant example for AWS & serverless & nodejs env

# REFERENCE

- https://knowledge.sakura.ad.jp/2882/
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html
- github.com repositories
  - https://github.com/djyugg/ansible-role-nodebrew
  - https://github.com/suzuki-shunsuke/ansible-nodebrew

## PROVISIONING

- box: ubuntu/bionic64
- node v16.13.0 (fixed)
  - you can change the version in group_vars/all
- awscli 1.19.112 (latest as of 2021-11)
- serverless 2.65.0 (latest as of 2021-11)
