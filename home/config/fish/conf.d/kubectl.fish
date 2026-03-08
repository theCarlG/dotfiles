# Fish kubectl aliastions (oh-my-zsh=kubectl plugin style)
# Save to: ~/.config/fish/conf.d/kubectl.fish

if not command -q kubectl
    return
end

# -----------------------------------------------------------------------------
# Core kubectl
# -----------------------------------------------------------------------------

alias k=kubectl

# Apply/Create/Delete
alias ka='kubectl apply'
alias kaf='kubectl apply -f'
alias kak='kubectl apply -k'
alias kcr='kubectl create'
alias kcrf='kubectl create -f'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kdelk='kubectl delete -k'

# Get
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'
alias kgw='kubectl get --watch'
alias kgwide='kubectl get -o wide'

# Get Pods
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kubectl get pods --watch'
alias kgpwide='kubectl get pods -o wide'
alias kgpl='kubectl get pods -l'
alias kgpn='kubectl get pods -n'

# Get Deployments
alias kgd='kubectl get deployments'
alias kgda='kubectl get deployments --all-namespaces'
alias kgdw='kubectl get deployments --watch'
alias kgdwide='kubectl get deployments -o wide'

# Get Services
alias kgs='kubectl get services'
alias kgsa='kubectl get services --all-namespaces'
alias kgsw='kubectl get services --watch'
alias kgswide='kubectl get services -o wide'

# Get Ingress
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'

# Get ConfigMaps/Secrets
alias kgcm='kubectl get configmaps'
alias kgsec='kubectl get secrets'

# Get Namespaces
alias kgns='kubectl get namespaces'

# Get Nodes
alias kgno='kubectl get nodes'
alias kgnowide='kubectl get nodes -o wide'

# Get PV/PVC
alias kgpv='kubectl get persistentvolumes'
alias kgpvc='kubectl get persistentvolumeclaims'
alias kgpvca='kubectl get persistentvolumeclaims --all-namespaces'

# Get StatefulSets
alias kgss='kubectl get statefulsets'
alias kgssa='kubectl get statefulsets --all-namespaces'
alias kgssw='kubectl get statefulsets --watch'
alias kgsswide='kubectl get statefulsets -o wide'

# Get DaemonSets
alias kgds='kubectl get daemonsets'
alias kgdsa='kubectl get daemonsets --all-namespaces'

# Get ReplicaSets
alias kgrs='kubectl get replicasets'
alias kgrsa='kubectl get replicasets --all-namespaces'

# Get Jobs/CronJobs
alias kgj='kubectl get jobs'
alias kgja='kubectl get jobs --all-namespaces'
alias kgcj='kubectl get cronjobs'
alias kgcja='kubectl get cronjobs --all-namespaces'

# Get Events
alias kgev='kubectl get events'
alias kgeva='kubectl get events --all-namespaces'
alias kgevw='kubectl get events --watch'

# Get ServiceAccounts
alias kgsar='kubectl get serviceaccounts'

# Get NetworkPolicies
alias kgnp='kubectl get networkpolicies'

# Get Endpoints
alias kgep='kubectl get endpoints'

# -----------------------------------------------------------------------------
# Describe
# -----------------------------------------------------------------------------

alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdi='kubectl describe ingress'
alias kdcm='kubectl describe configmap'
alias kdsec='kubectl describe secret'
alias kdno='kubectl describe node'
alias kdns='kubectl describe namespace'
alias kdpv='kubectl describe persistentvolume'
alias kdpvc='kubectl describe persistentvolumeclaim'
alias kdss='kubectl describe statefulset'
alias kdds='kubectl describe daemonset'
alias kdrs='kubectl describe replicaset'
alias kdj='kubectl describe job'
alias kdcj='kubectl describe cronjob'

# -----------------------------------------------------------------------------
# Edit
# -----------------------------------------------------------------------------

alias ke='kubectl edit'
alias kep='kubectl edit pod'
alias ked='kubectl edit deployment'
alias kes='kubectl edit service'
alias kei='kubectl edit ingress'
alias kecm='kubectl edit configmap'
alias kesec='kubectl edit secret'
alias kess='kubectl edit statefulset'
alias keds='kubectl edit daemonset'

# -----------------------------------------------------------------------------
# Logs
# -----------------------------------------------------------------------------

alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klp='kubectl logs -p'
alias kla='kubectl logs --all-containers'
alias klfa='kubectl logs -f --all-containers'

# -----------------------------------------------------------------------------
# Exec
# -----------------------------------------------------------------------------

alias kex='kubectl exec -it'
alias kexsh='kubectl exec -it -- sh'
alias kexbash='kubectl exec -it -- bash'

# -----------------------------------------------------------------------------
# Port Forward
# -----------------------------------------------------------------------------

alias kpf='kubectl port-forward'

# -----------------------------------------------------------------------------
# Scale
# -----------------------------------------------------------------------------

alias ksc='kubectl scale'
alias kscd='kubectl scale deployment'
alias kscss='kubectl scale statefulset'
alias kscrs='kubectl scale replicaset'

# -----------------------------------------------------------------------------
# Rollout
# -----------------------------------------------------------------------------

alias kro='kubectl rollout'
alias kros='kubectl rollout status'
alias kroh='kubectl rollout history'
alias krou='kubectl rollout undo'
alias kror='kubectl rollout restart'
alias krosd='kubectl rollout status deployment'
alias krord='kubectl rollout restart deployment'
alias kroud='kubectl rollout undo deployment'
alias krohd='kubectl rollout history deployment'

# -----------------------------------------------------------------------------
# Namespace & Context
# -----------------------------------------------------------------------------

alias kns='kubectl config set-context --current --namespace'
alias kcgc='kubectl config get-contexts'
alias kcuc='kubectl config use-context'
alias kccc='kubectl config current-context'
alias kcdc='kubectl config delete-context'
alias kcsc='kubectl config set-context'
alias kcgcl='kubectl config get-clusters'

# -----------------------------------------------------------------------------
# Top (metrics)
# -----------------------------------------------------------------------------

alias kt='kubectl top'
alias ktp='kubectl top pods'
alias ktpa='kubectl top pods --all-namespaces'
alias ktn='kubectl top nodes'
alias ktc='kubectl top pods --containers'

# -----------------------------------------------------------------------------
# Run
# -----------------------------------------------------------------------------

alias kr='kubectl run'
alias krit='kubectl run -it --rm --restart=Never --image'

# -----------------------------------------------------------------------------
# Copy
# -----------------------------------------------------------------------------

alias kcp='kubectl cp'

# -----------------------------------------------------------------------------
# Label & Annotate
# -----------------------------------------------------------------------------

alias kla='kubectl label'
alias kan='kubectl annotate'

# -----------------------------------------------------------------------------
# Patch
# -----------------------------------------------------------------------------

alias kpatch='kubectl patch'

# -----------------------------------------------------------------------------
# API Resources
# -----------------------------------------------------------------------------

alias kar='kubectl api-resources'
alias kav='kubectl api-versions'

# -----------------------------------------------------------------------------
# Explain
# -----------------------------------------------------------------------------

alias kexp='kubectl explain'
alias kexpr='kubectl explain --recursive'

# -----------------------------------------------------------------------------
# Diff & Dry Run
# -----------------------------------------------------------------------------

alias kdiff='kubectl diff -f'
alias kafd='kubectl apply -f --dry-run=client'
alias kafds='kubectl apply -f --dry-run=server'

# -----------------------------------------------------------------------------
# Debug
# -----------------------------------------------------------------------------

alias kdbg='kubectl debug'

# -----------------------------------------------------------------------------
# Output formats
# -----------------------------------------------------------------------------

alias kgy='kubectl get -o yaml'
alias kgj='kubectl get -o json'
alias kgjq='kubectl get -o json | jq'

# -----------------------------------------------------------------------------
# Wait
# -----------------------------------------------------------------------------

alias kwait='kubectl wait'

# -----------------------------------------------------------------------------
# Auth
# -----------------------------------------------------------------------------

alias kauth='kubectl auth'
alias kauthc='kubectl auth can-i'

# -----------------------------------------------------------------------------
# Certificate
# -----------------------------------------------------------------------------

alias kcert='kubectl certificate'
alias kcerta='kubectl certificate approve'
alias kcertd='kubectl certificate deny'

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

# Quick namespace switch
function kn --description "Switch kubectl namespace"
    if test -z "$argv[1]"
        kubectl config view --minify --output 'jsonpath={..namespace}'; echo
    else
        kubectl config set-context --current --namespace=$argv[1]
    end
end

# Quick context switch
function kc --description "Switch kubectl context"
    if test -z "$argv[1]"
        kubectl config current-context
    else
        kubectl config use-context $argv[1]
    end
end

# Get all resources in namespace
function kgetall --description "Get all resources in namespace"
    set -l ns $argv[1]
    if test -z "$ns"
        set ns (kubectl config view --minify --output 'jsonpath={..namespace}')
        test -z "$ns"; and set ns default
    end
    kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $ns
end

# Shell into pod (first container)
function ksh --description "Shell into pod"
    if test -z "$argv[1]"
        echo "Usage: ksh <pod> [namespace]" >&2
        return 1
    end
    set -l pod $argv[1]
    set -l ns_flag
    if test -n "$argv[2]"
        set ns_flag -n $argv[2]
    end
    kubectl exec -it $ns_flag $pod -- sh -c "command -v bash >/dev/null && exec bash || exec sh"
end

# Watch pods (with optional label selector)
function kwatch --description "Watch pods"
    if test -n "$argv[1]"
        kubectl get pods -l $argv[1] --watch
    else
        kubectl get pods --watch
    end
end

# Tail logs from multiple pods by label
function klogs --description "Tail logs from pods by label"
    if test -z "$argv[1]"
        echo "Usage: klogs <label-selector> [container]" >&2
        return 1
    end
    set -l selector $argv[1]
    set -l container_flag
    if test -n "$argv[2]"
        set container_flag -c $argv[2]
    end
    kubectl logs -f -l $selector $container_flag --max-log-requests=10
end

# Force delete pod
function kdelforce --description "Force delete pod"
    if test -z "$argv[1]"
        echo "Usage: kdelforce <pod> [namespace]" >&2
        return 1
    end
    set -l pod $argv[1]
    set -l ns_flag
    if test -n "$argv[2]"
        set ns_flag -n $argv[2]
    end
    kubectl delete pod $ns_flag $pod --grace-period=0 --force
end

# Restart deployment
function krestart --description "Restart deployment"
    if test -z "$argv[1]"
        echo "Usage: krestart <deployment> [namespace]" >&2
        return 1
    end
    set -l deploy $argv[1]
    set -l ns_flag
    if test -n "$argv[2]"
        set ns_flag -n $argv[2]
    end
    kubectl rollout restart deployment $ns_flag $deploy
end

# Get pod by partial name
function kgpod --description "Get pod by partial name"
    if test -z "$argv[1]"
        echo "Usage: kgpod <partial-name>" >&2
        return 1
    end
    kubectl get pods | grep -i $argv[1]
end

# Decode secret
function ksecdec --description "Decode secret data"
    if test -z "$argv[1]"
        echo "Usage: ksecdec <secret-name> [key] [namespace]" >&2
        return 1
    end
    set -l secret $argv[1]
    set -l key $argv[2]
    set -l ns_flag
    if test -n "$argv[3]"
        set ns_flag -n $argv[3]
    end
    
    if test -n "$key"
        kubectl get secret $ns_flag $secret -o jsonpath="{.data.$key}" | base64 -d; echo
    else
        kubectl get secret $ns_flag $secret -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d)"'
    end
end

# -----------------------------------------------------------------------------
# Completions for custom functions
# -----------------------------------------------------------------------------

# Namespace completion for kn
function __fish_kn_namespaces
    kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' 2>/dev/null | tr ' ' '\n'
end
complete -c kn -f -a "(__fish_kn_namespaces)"

# Context completion for kc
function __fish_kc_contexts
    kubectl config get-contexts -o name 2>/dev/null
end
complete -c kc -f -a "(__fish_kc_contexts)"

# Pod completion for ksh
function __fish_k_pods
    kubectl get pods -o jsonpath='{.items[*].metadata.name}' 2>/dev/null | tr ' ' '\n'
end
complete -c ksh -f -a "(__fish_k_pods)"
complete -c kdelforce -f -a "(__fish_k_pods)"

# Deployment completion for krestart
function __fish_k_deployments
    kubectl get deployments -o jsonpath='{.items[*].metadata.name}' 2>/dev/null | tr ' ' '\n'
end
complete -c krestart -f -a "(__fish_k_deployments)"

# Secret completion for ksecdec
function __fish_k_secrets
    kubectl get secrets -o jsonpath='{.items[*].metadata.name}' 2>/dev/null | tr ' ' '\n'
end
complete -c ksecdec -f -a "(__fish_k_secrets)"

# -----------------------------------------------------------------------------
# Integration with kubectx/kubens (if installed)
# -----------------------------------------------------------------------------

if command -q kubectx
    alias kctx=kubectx
end

if command -q kubens
    alias knss=kubens
end

# -----------------------------------------------------------------------------
# Integration with stern (if installed)
# -----------------------------------------------------------------------------

if command -q stern
    alias ks=stern
    alias ksa='stern --all-namespaces'
    alias kss='stern --since 1h'
end

# -----------------------------------------------------------------------------
# Integration with k9s (if installed)
# -----------------------------------------------------------------------------

if command -q k9s
    alias k9=k9s
    alias k9a='k9s --all-namespaces'
end
