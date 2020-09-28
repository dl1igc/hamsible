#/bin/bash

#ansible-playbook --user pi --ask-pass --inventory raspberrypi.local, password.yml
ansible-playbook --user nacho --ask-pass --ask-become-pass --inventory nacho-keller.local, playbook.yml