# High Interaction Honeypots with Sysdig and Falco #

Sysdig is an open source tool, which can capture and save system state and activity from a running Linux machine. Falco, an open source tool as well, is a behavioral activity monitor designed to detect anomalous activity in applications. Falco can detect and alert on any behavior that involves making Linux system calls.

## Description ##

The honeypot_recipes repository contains a chef cookbook which can be used to quickly deploy a high interaction honeypot, using the sysdig and falco tools. The cookbook can be deployed under Red Hat, CentOS, Fedora, Ubuntu and Debian operating systems.

The cookbook installs sysdig and falco tools. In addition it creates an init script under /etc/init.d/ directory which starts sysdig in file roration mode for continuous capture. All the files that sysdig produces are written under the /local/usr/src/ directory, which can be changed by modifing the init scirpt.

## How to run the cookbook ##

In order to run the cookbook you should install:
* git
* chefdk <https://downloads.chef.io/chefdk>

Create a directory named **cookbooks** and clone the repository in the new directory:
`mkdir cookbooks && cd cookbooks`
`git clone https://github.com/mwrlabs/honeypot_recipes sysdig-falco`

Run the cookbook with the following command:
`chef-client --local-mode --runlist 'recipe[sysdig-falco]'`

## License ##

## Contact ##

Please submit any bugs on the Github project page at:

<https://github.com/panagioto/honeypot_recipes>
