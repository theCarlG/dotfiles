# Fish kubectl abbreviations (oh-my-zsh kubectl plugin style)
# Save to: ~/.config/fish/conf.d/kubectl.fish

if not command -q kubectl
    return
end

# -----------------------------------------------------------------------------
# Core kubectl
# -----------------------------------------------------------------------------

abbr -a k kubectl

# Apply/Create/Delete
abbr -a ka 'kubectl apply'
abbr -a kaf 'kubectl apply -f'
abbr -a kak 'kubectl apply -k'
abbr -a kcr 'kubectl create'
abbr -a kcrf 'kubectl create -f'
abbr -a kdel 'kubectl delete'
abbr -a kdelf 'kubectl delete -f'
abbr -a kdelk 'kubectl delete -k'

# Get
abbr -a kg 'kubectl get'
abbr -a kga 'kubectl get all'
abbr -a kgaa 'kubectl get all --all-namespaces'
abbr -a kgw 'kubectl get --watch'
abbr -a kgwide 'kubectl get -o wide'

# Get Pods
abbr -a kgp 'kubectl get pods'
abbr -a kgpa 'kubectl get pods --all-namespaces'
abbr -a kgpw 'kubectl get pods --watch'
abbr -a kgpwide 'kubectl get pods -o wide'
abbr -a kgpl 'kubectl get pods -l'
abbr -a kgpn 'kubectl get pods -n'

# Get Deployments
abbr -a kgd 'kubectl get deployments'
abbr -a kgda 'kubectl get deployments --all-namespaces'
abbr -a kgdw 'kubectl get deployments --watch'
abbr -a kgdwide 'kubectl get deployments -o wide'

# Get Services
abbr -a kgs 'kubectl get services'
abbr -a kgsa 'kubectl get services --all-namespaces'
abbr -a kgsw 'kubectl get services --watch'
abbr -a kgswide 'kubectl get services -o wide'

# Get Ingress
abbr -a kgi 'kubectl get ingress'
abbr -a kgia 'kubectl get ingress --all-namespaces'

# Get ConfigMaps/Secrets
abbr -a kgcm 'kubectl get configmaps'
abbr -a kgsec 'kubectl get secrets'

# Get Namespaces
abbr -a kgns 'kubectl get namespaces'

# Get Nodes
abbr -a kgno 'kubectl get nodes'
abbr -a kgnowide 'kubectl get nodes -o wide'

# Get PV/PVC
abbr -a kgpv 'kubectl get persistentvolumes'
abbr -a kgpvc 'kubectl get persistentvolumeclaims'
abbr -a kgpvca 'kubectl get persistentvolumeclaims --all-namespaces'

# Get StatefulSets
abbr -a kgss 'kubectl get statefulsets'
abbr -a kgssa 'kubectl get statefulsets --all-namespaces'
abbr -a kgssw 'kubectl get statefulsets --watch'
abbr -a kgsswide 'kubectl get statefulsets -o wide'

# Get DaemonSets
abbr -a kgds 'kubectl get daemonsets'
abbr -a kgdsa 'kubectl get daemonsets --all-namespaces'

# Get ReplicaSets
abbr -a kgrs 'kubectl get replicasets'
abbr -a kgrsa 'kubectl get replicasets --all-namespaces'

# Get Jobs/CronJobs
abbr -a kgj 'kubectl get jobs'
abbr -a kgja 'kubectl get jobs --all-namespaces'
abbr -a kgcj 'kubectl get cronjobs'
abbr -a kgcja 'kubectl get cronjobs --all-namespaces'

# Get Events
abbr -a kgev 'kubectl get events'
abbr -a kgeva 'kubectl get events --all-namespaces'
abbr -a kgevw 'kubectl get events --watch'

# Get ServiceAccounts
abbr -a kgsar 'kubectl get serviceaccounts'

# Get NetworkPolicies
abbr -a kgnp 'kubectl get networkpolicies'

# Get Endpoints
abbr -a kgep 'kubectl get endpoints'

# -----------------------------------------------------------------------------
# Describe
# -----------------------------------------------------------------------------

abbr -a kd 'kubectl describe'
abbr -a kdp 'kubectl describe pod'
abbr -a kdd 'kubectl describe deployment'
abbr -a kds 'kubectl describe service'
abbr -a kdi 'kubectl describe ingress'
abbr -a kdcm 'kubectl describe configmap'
abbr -a kdsec 'kubectl describe secret'
abbr -a kdno 'kubectl describe node'
abbr -a kdns 'kubectl describe namespace'
abbr -a kdpv 'kubectl describe persistentvolume'
abbr -a kdpvc 'kubectl describe persistentvolumeclaim'
abbr -a kdss 'kubectl describe statefulset'
abbr -a kdds 'kubectl describe daemonset'
abbr -a kdrs 'kubectl describe replicaset'
abbr -a kdj 'kubectl describe job'
abbr -a kdcj 'kubectl describe cronjob'

# -----------------------------------------------------------------------------
# Edit
# -----------------------------------------------------------------------------

abbr -a ke 'kubectl edit'
abbr -a kep 'kubectl edit pod'
abbr -a ked 'kubectl edit deployment'
abbr -a kes 'kubectl edit service'
abbr -a kei 'kubectl edit ingress'
abbr -a kecm 'kubectl edit configmap'
abbr -a kesec 'kubectl edit secret'
abbr -a kess 'kubectl edit statefulset'
abbr -a keds 'kubectl edit daemonset'

# -----------------------------------------------------------------------------
# Logs
# -----------------------------------------------------------------------------

abbr -a kl 'kubectl logs'
abbr -a klf 'kubectl logs -f'
abbr -a kl1h 'kubectl logs --since 1h'
abbr -a kl1m 'kubectl logs --since 1m'
abbr -a kl1s 'kubectl logs --since 1s'
abbr -a klp 'kubectl logs -p'
abbr -a kla 'kubectl logs --all-containers'
abbr -a klfa 'kubectl logs -f --all-containers'

# -----------------------------------------------------------------------------
# Exec
# -----------------------------------------------------------------------------

abbr -a kex 'kubectl exec -it'
abbr -a kexsh 'kubectl exec -it -- sh'
abbr -a kexbash 'kubectl exec -it -- bash'

# -----------------------------------------------------------------------------
# Port Forward
# -----------------------------------------------------------------------------

abbr -a kpf 'kubectl port-forward'

# -----------------------------------------------------------------------------
# Scale
# -----------------------------------------------------------------------------

abbr -a ksc 'kubectl scale'
abbr -a kscd 'kubectl scale deployment'
abbr -a kscss 'kubectl scale statefulset'
abbr -a kscrs 'kubectl scale replicaset'

# -----------------------------------------------------------------------------
# Rollout
# -----------------------------------------------------------------------------

abbr -a kro 'kubectl rollout'
abbr -a kros 'kubectl rollout status'
abbr -a kroh 'kubectl rollout history'
abbr -a krou 'kubectl rollout undo'
abbr -a kror 'kubectl rollout restart'
abbr -a krosd 'kubectl rollout status deployment'
abbr -a krord 'kubectl rollout restart deployment'
abbr -a kroud 'kubectl rollout undo deployment'
abbr -a krohd 'kubectl rollout history deployment'

# -----------------------------------------------------------------------------
# Namespace & Context
# -----------------------------------------------------------------------------

abbr -a kns 'kubectl config set-context --current --namespace'
abbr -a kcgc 'kubectl config get-contexts'
abbr -a kcuc 'kubectl config use-context'
abbr -a kccc 'kubectl config current-context'
abbr -a kcdc 'kubectl config delete-context'
abbr -a kcsc 'kubectl config set-context'
abbr -a kcgcl 'kubectl config get-clusters'

# -----------------------------------------------------------------------------
# Top (metrics)
# -----------------------------------------------------------------------------

abbr -a kt 'kubectl top'
abbr -a ktp 'kubectl top pods'
abbr -a ktpa 'kubectl top pods --all-namespaces'
abbr -a ktn 'kubectl top nodes'
abbr -a ktc 'kubectl top pods --containers'

# -----------------------------------------------------------------------------
# Run
# -----------------------------------------------------------------------------

abbr -a kr 'kubectl run'
abbr -a krit 'kubectl run -it --rm --restart=Never --image'

# -----------------------------------------------------------------------------
# Copy
# -----------------------------------------------------------------------------

abbr -a kcp 'kubectl cp'

# -----------------------------------------------------------------------------
# Label & Annotate
# -----------------------------------------------------------------------------

abbr -a kla 'kubectl label'
abbr -a kan 'kubectl annotate'

# -----------------------------------------------------------------------------
# Patch
# -----------------------------------------------------------------------------

abbr -a kpatch 'kubectl patch'

# -----------------------------------------------------------------------------
# API Resources
# -----------------------------------------------------------------------------

abbr -a kar 'kubectl api-resources'
abbr -a kav 'kubectl api-versions'

# -----------------------------------------------------------------------------
# Explain
# -----------------------------------------------------------------------------

abbr -a kexp 'kubectl explain'
abbr -a kexpr 'kubectl explain --recursive'

# -----------------------------------------------------------------------------
# Diff & Dry Run
# -----------------------------------------------------------------------------

abbr -a kdiff 'kubectl diff -f'
abbr -a kafd 'kubectl apply -f --dry-run=client'
abbr -a kafds 'kubectl apply -f --dry-run=server'

# -----------------------------------------------------------------------------
# Debug
# -----------------------------------------------------------------------------

abbr -a kdbg 'kubectl debug'

# -----------------------------------------------------------------------------
# Output formats
# -----------------------------------------------------------------------------

abbr -a kgy 'kubectl get -o yaml'
abbr -a kgj 'kubectl get -o json'
abbr -a kgjq 'kubectl get -o json | jq'

# -----------------------------------------------------------------------------
# Wait
# -----------------------------------------------------------------------------

abbr -a kwait 'kubectl wait'

# -----------------------------------------------------------------------------
# Auth
# -----------------------------------------------------------------------------

abbr -a kauth 'kubectl auth'
abbr -a kauthc 'kubectl auth can-i'

# -----------------------------------------------------------------------------
# Certificate
# -----------------------------------------------------------------------------

abbr -a kcert 'kubectl certificate'
abbr -a kcerta 'kubectl certificate approve'
abbr -a kcertd 'kubectl certificate deny'

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
    abbr -a kctx kubectx
end

if command -q kubens
    abbr -a knss kubens
end

# -----------------------------------------------------------------------------
# Integration with stern (if installed)
# -----------------------------------------------------------------------------

if command -q stern
    abbr -a ks stern
    abbr -a ksa 'stern --all-namespaces'
    abbr -a kss 'stern --since 1h'
end

# -----------------------------------------------------------------------------
# Integration with k9s (if installed)
# -----------------------------------------------------------------------------

if command -q k9s
    abbr -a k9 k9s
    abbr -a k9a 'k9s --all-namespaces'
end
