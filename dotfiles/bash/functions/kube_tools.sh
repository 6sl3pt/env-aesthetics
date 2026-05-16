#!/bin/bash

function kprune-rs() {
  echo "Searching for inactive ReplicaSets..."

  local rs_list
  rs_list=$(kubectl get replicaset --all-namespaces -o=jsonpath='{range .items[?(@.spec.replicas==0)]}{.metadata.name}{" "}{.metadata.namespace}{"\n"}{end}')

  if [[ -z "$rs_list" ]]; then
    echo "No inactive ReplicaSets found."
    return 0
  fi

  echo "$rs_list" | while read -r name namespace; do
    echo "Deleting ReplicaSet: $name in $namespace"
    kubectl delete replicaset "$name" -n "$namespace"
  done
}
