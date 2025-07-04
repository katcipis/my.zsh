function kundo() {
    local deploy="${1}"
    local rev="${2}"

    if [[ -z "${deploy}" ]] then
        echo "deployment name not informed"
        printf "usage: %s <deployment name> <rev>\n" ${0}
        return
    fi

    if [[ -z "${rev}" ]] then
        echo "revision not informed"
        printf "usage: %s <deployment name> <rev>\n" ${0}
        return
    fi

    printf "undoing deployment[%s] to revision[%s]\n" ${deploy} ${rev}
    kubectl rollout undo deployment/${deploy} --to-revision=${rev}
}

function kdrain() {
    kubectl drain --delete-emptydir-data --ignore-daemonsets "$@"
}

function kupdate() {
    local name="${1}"
    local imgversion="${2}"

    if [[ -z "${name}" ]] then
        echo "deployment name not informed"
        printf "usage: %s <deployment name> <image version>\n" ${0}
        return
    fi

    if [[ -z "${imgversion}" ]] then
        echo "image version not informed"
        printf "usage: %s <deployment name> <image version>\n" ${0}
        return
    fi

    kubectl set image "deployment/${name}" "${name}=${imgversion}" --record
}

function krev() {
    local deploy="${1}"

    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deployment name> <revision (optional)\n" ${0}
        return
    fi

    local rev="${2}"

    if [[ -z "${rev}" ]] then
        printf "listing deployment[%s] revisions\n" ${deploy}
        kubectl rollout history deployment/${deploy}
        return
    fi

    printf "detailing deployment[%s] revision[%s]\n" ${deploy} ${rev}
    kubectl rollout history deployment/${deploy} --revision=${rev}
}

function kevents_json_all() {
    kubectl get events --sort-by='.lastTimestamp' --output=json
}

function kevents() {
    local evtype="${1}"

    if [[ -z "${evtype}" ]] then
        kevents_json_all
        return
    fi

    local filter=$(printf '.items[] | select(.type=="%s")' "${evtype}")
    kevents_json_all | jq "${filter}"
}

function klogs() {
    local deployment="${1}"

    if [[ -z "${deployment}" ]] then
        printf "usage: %s <deploy name>\n" ${0}
        return
    fi

    kubectl logs -f deployment/${deployment} --all-pods=true --max-log-requests 100
}

function kautocomplete() {
    if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
}

function kimgver() {
    local deploy="${1}"
    local container="${2}"

    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deploy name> <container name>(optional,default=<deploy name>)\n" ${0}
        return
    fi

    if [[ -z "${container}" ]] then
        container="${deploy}"
    fi

    local filter=$(printf '.spec.template.spec.containers[] | if .name == "%s" then .image else empty end' "${container}")

    kubectl -o json get "deployment/${deploy}" | jq -r "${filter}"
}

function krestart() {
    local deploy="${1}"
    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deploy name>\n" ${0}
        return
    fi
    kubectl rollout restart deployment "${deploy}"
}

function kshell() {
    local namespace="${1}"
    if [[ -z "${namespace}" ]] then
        printf "usage: %s <namespace> <image(optional)>\n" ${0}
        return
    fi

    local image="${2}"
    if [[ -z "${image}" ]] then
        image="ubuntu"
    fi

    kubectl run -i --tty katcipis-shell --rm=true --restart=Never --namespace "${namespace}" --image="${image}" --command -- bash
}

function knset() {
    local namespace="${1}"
    if [[ -z "${namespace}" ]] then
        printf "usage: %s <namespace>\n" ${0}
        return
    fi
    kubectl config set-context --current --namespace="${namespace}"
}

function kns() {
    kubectl config view --minify | grep namespace:
}

function kpods() {
    local filter="${1}"
    if [[ -z "${filter}" ]] then
        printf "usage: %s <pod status>\n" ${0}
        return
    fi
    kubectl get pod  | grep "${filter}" | awk '{print $1}'
}

function kpodskill() {
    local filter="${1}"
    if [[ -z "${filter}" ]] then
        printf "usage: %s <pod status that will be deleted>\n" ${0}
        return
    fi
    kpods "${filter}" | xargs kubectl delete pod
}

function kterminated() {
    # Get all namespaces in the cluster
    local namespaces
    local pods

    namespaces=$(kubectl get namespaces -o=jsonpath='{.items[*].metadata.name}')

    # Loop through each namespace
    for namespace in "${=namespaces}"; do
        echo "Namespace: $namespace"
        echo "------------------------"

        # Get all pod names in the namespace
        pods=$(kubectl get pods -n $namespace -o=jsonpath='{range .items[*]}{.metadata.name}{" "}{end}')

        # Loop through each pod
        for pod in "${=pods}"; do
            # Get the termination reason for the pod
            reasons=$(kubectl get pod -n $namespace $pod -o=jsonpath='{.status.containerStatuses[*].lastState.terminated.reason}')
            if [[ -z "${reasons}" ]] then
                continue
            fi
            for reason in "${=reasons}"; do
                echo "Pod '$pod' terminated due to '$reason'"
            done
        done
    done
}
