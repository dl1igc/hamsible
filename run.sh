#/bin/bash

#ansible-playbook --user pi --ask-pass --inventory raspberrypi.local, password.yml
ansible-playbook --user ubuntu --ask-pass --inventory hampi.local, playbook.yml