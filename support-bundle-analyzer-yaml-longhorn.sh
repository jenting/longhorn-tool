#!/bin/bash

echo "nodes.longhorn.io"
./yamls/longhorn/nodes.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"MountPropagation\",\"Ready\",\"Schedulable\"]), (.[] | [.objectmeta.name, (.status.conditions[] | select(.type == \"MountPropagation\") | .status), (.status.conditions[] | select(.type == \"Ready\") | .status), (.status.conditions[] | select(.type == \"Schedulable\") | .status)]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;
./yamls/longhorn/nodes.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"PATH\",\"ALLOW_SCHEDULING\",\"EVICTION_REQUESTED\",\"STORAGE_RESERVED\"]), (.[] | [.objectmeta.name, .spec.disks[].path, .spec.disks[].allowscheduling, .spec.disks[].evictionrequested, .spec.disks[].storagereserved]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;
./yamls/longhorn/nodes.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"STORAGE_AVAILABLE\",\"STORAGE_SCHEDULED\",\"STORAGE_MAXIMUM\"]), (.[] | [.objectmeta.name, .status.diskstatus[].storageavailable, .status.diskstatus[].storagescheduled, .status.diskstatus[].storagemaximum]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "settings.longhorn.io"
./yamls/longhorn/settings.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"VALUE\"]), (.[] | [.objectmeta.name, .setting.value]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "volumes.longhorn.io"
./yamls/longhorn/volumes.yaml -exec bash -c "cat {} | yq -r '([\"NODE\",\"NAME\",\"WORKLOAD\",\"NAMESPACE\",\"STATE\",\"STATUS\",\"DISK_SEL\",\"NODE_SEL\",\"SIZE\",\"ACTUAL_SIZE\",\"REPLICA\",\"RESTORE\",\"SCHEDULED\",\"TNS\"]), (.[] | [.status.currentnodeid, .objectmeta.name, .status.kubernetesstatus.workloadsstatus[0].workloadname, .status.kubernetesstatus.namespace, .status.state, .status.robustness, .spec.diskselector[0], .spec.nodeselector[0], .spec.size, .status.actualsize, .spec.numberofreplicas, (.status.conditions[] | select(.type == \"restore\") | .status), (.status.conditions[] | select(.type == \"scheduled\") | .status), (.status.conditions[] | select(.type == \"toomanysnapshots\") | .status)]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "instancemanagers.longhorn.io"
./yamls/longhorn/instancemanagers.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"NODE\",\"STATUS\",\"IP\"]), (.[] | [.objectmeta.name, .status.ownerid, .status.currentstate, .status.ip]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "engineimages.longhorn.io"
./yamls/longhorn/engineimages.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"NODE\",\"STATUS\"]), (.[] | [.objectmeta.name, .status.ownerid, .status.currentstate]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "engines.longhorn.io"
./yamls/longhorn/engines.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"NODE\",\"MANAGER\",\"STATUS\",\"SIZE\",\"Actual\"]), (.[] | [.objectmeta.name, .status.instancestatus.ownerid, .status.instancestatus.instancemanagername, .status.instancestatus.currentstate, .spec.instancespec.volumesize, .status.currentsize]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "replicas.longhorn.io"
./yamls/longhorn/replicas.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"NODE\",\"MANAGER\",\"STATUS\",\"SIZE\",\"PATH\"]), (.[] | [.objectmeta.name, .status.instancestatus.ownerid, .status.instancestatus.instancemanagername, .status.instancestatus.currentstate, .spec.instancespec.volumesize, .spec.diskpath]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;

echo "backingimages.longhorn.io"
./yamls/longhorn/backingimages.yaml -exec bash -c "cat {} | yq -r '([\"NAME\",\"NODE\",\"STATUS\"]), (.[] | [.objectmeta.name, .status.ownerid, .status.currentstate]) | @tsv' | (sed -u 1q; sort) | column -ts $'\t'" {} \;
