#!/bin/bash
#
# The webhook was triggered. Clone the configured Ansible repository and run the playbook.

set -euo pipefail

# Collect configuration values and set defaults.

REPO=${HEATLAMP_ANSIBLE_REPO:-}

BRANCH=${HEATLAMP_ANSIBLE_BRANCH:-master}
PLAYBOOK=${HEATLAMP_ANSIBLE_PLAYBOOK:-site.yml}
AMODULES=${HEATLAMP_ANSIBLE_MODULES:-}
AGROUPS=${HEATLAMP_ANSIBLE_GROUPS:-}
ATAGS=${HEATLAMP_ANSIBLE_TAGS:-}

# Validate the presence of required environment variables.
# Echo the configuration to stdout for verification.

[ -n "${REPO}" ] || {
  cat <<EOM 1>&2
Missing the required environment variable:

 HEATLAMP_ANSIBLE_REPO: URL of the git repository containing the Ansible playbook to execute.

EOM
  exit 1
}

# Prepare the workspace.

WORKSPACE=/var/heatlamp/playbook

rm -rf ${WORKSPACE}
mkdir -p /var/heatlamp

# Perform a shallow clone of the repository.
git clone --quiet --depth 1 --branch "${BRANCH}" "${REPO}" "${WORKSPACE}"
cd ${WORKSPACE}

# Generate the inventory.

INVENTORY=${WORKSPACE}/inventory

cat <<PART > ${INVENTORY}
localhost

PART

IFS=','
echo ">> AGROUPS: <${AGROUPS}>"
for AGROUP in ${AGROUPS}; do
  echo ">> AGROUP is ${AGROUP}"
  cat <<PART >> ${INVENTORY}
[${AGROUP}]
localhost

PART
done

# Generate Ansible's arguments.

AARGS=

[ ! -z "${AMODULES}" ] && AARGS="${AARGS} -M ${AMODULES}"
[ ! -z "${ATAGS}" ] && AARGS="${AARGS} --tags ${ATAGS}"

# Execute Ansible.

exec ansible-playbook \
  --inventory-file "${INVENTORY}" \
  ${AARGS} \
  ${PLAYBOOK}
