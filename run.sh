#!/bin/bash

CHOICE=$(gum choose run-playbook build-image gen-key )

if [[ $CHOICE == "run-playbook" ]]; then
  PLAYBOOK=$(gum choose main local )
  gum confirm "Proceed with CM install?"  --default=0 && PROCEED=1 || PROCEED=0
  if [[ $PROCEED == 1 ]]; then
    echo "Running"
    if [[ $PLAYBOOK == "main" ]]; then
      ansible-playbook ./playbook.yml -i inventory.ini --ask-become-pass
    elif [[ $PLAYBOOK == "local" ]]; then
      pushd ./plays/local
      ansible-playbook ./playbook.yml -i ./inventory.ini --ask-become-pass
      popd
    fi
  else
    echo "Good bye."
  fi
elif [[ $CHOICE == "build-image" ]]; then
  podman build -f Dockerfile -t prime-rhel .
elif [[ $CHOICE == "gen-key" ]]; then
  mkdir -p ./ssh
  ssh-keygen -t rsa -f ./ssh/id_rsa
fi

# Example creating the roles from scratch
# ansible-galaxy init bastion
# ansible-galaxy init bastion-minion
