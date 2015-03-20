# heatlamp/ansible

*Execute an Ansible playbook to update your Docker containers*

[DockerHub](https://registry.hub.docker.com/u/heatlamp/ansible/) | [GitHub](https://github.com/heatlamp/heatlamp-ansible)

This is a specialization of [heatlamp](https://github.com/heatlamp/heatlamp-core) that uses Ansible to orchestrate updates. Each webhook execution will run the latest version of an Ansible playbook found in a git repository.

## Configuration

Configure heatlamp/ansible by setting the following environment variables in the heatlamp container.

`HEATLAMP_ANSIBLE_REPO`: **(required)** URL of a git repository containing the playbook you wish to execute.

`HEATLAMP_ANSIBLE_BRANCH`: Branch to checkout within the cloned git repository. *(Default: master)*

`HEATLAMP_ANSIBLE_PLAYBOOK`: Filesystem path, relative to the repository root, of the Ansible playbook to execute. *(Default: site.yml)*

`HEATLAMP_ANSIBLE_MODULES`: Filesystem path, relative to the repository root, of any custom Ansible modules to include in the execution. *(Default: none)*

`HEATLAMP_ANSIBLE_GROUPS`: Comma-separated list of host groups to inject `localhost` into with the generated inventory file. This is useful for getting `host:` lines to match properly, even if you're only intending to run tasks that target the current host. *(Default: none)*

`HEATLAMP_ANSIBLE_TAGS`: Comma-separated list of tags used to constrain the playbook execution. *(Default: none)*
