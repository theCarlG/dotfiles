# Fish git aliastions (oh-my-zsh=git plugin style)
# Save to: ~/.config/fish/conf.d/git.fish

if not command -q git
    return
end

# Git base
alias g='git'

# Add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'

# Branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbl='git blame -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

# Commit
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcn!='git commit --verbose --no-edit --amend'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcann!='git commit --verbose --all --date=now --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcam='git commit --all --message'
alias gcsm='git commit --signoff --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcmsg='git commit --message'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'

# Checkout
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main'
alias gcor='git checkout --recurse-submodules'

# Cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# Clone
alias gcl='git clone --recurse-submodules'

# Clean
alias gclean='git clean --interactive -d'
alias gpristine='git reset --hard && git clean --force -dfx'

# Diff
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias gdup='git diff @{upstream}'
alias gdnolock='git diff -- ":(exclude)Cargo.lock" ":(exclude)package-lock.json"'

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'

# Log
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms='git merge --squash'
alias gmom='git merge origin/main'
alias gmum='git merge upstream/main'

# Push
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpr='git pull --rebase'
alias gpu='git push upstream'
alias gpv='git push --verbose'

# Pull
alias gl='git pull'
alias gpr='git pull --rebase'
alias gprv='git pull --rebase --verbose'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash --verbose'
alias gprom='git pull --rebase origin main'
alias gpromi='git pull --rebase=interactive origin main'
alias ggpull='git pull origin (git branch --show-current)'

# Push current branch
alias ggpush='git push origin (git branch --show-current)'
alias gpsup='git push --set-upstream origin (git branch --show-current)'

# Rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbom='git rebase origin/main'
alias grbum='git rebase upstream/main'

# Remote
alias gr='git remote'
alias gra='git remote add'
alias grv='git remote --verbose'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'

# Reset
alias grh='git reset'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias grhu='git reset --hard @{upstream}'
alias gru='git reset --'

# Restore
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'

# Revert
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'

# Remove
alias grm='git rm'
alias grmc='git rm --cached'

# Status
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'

# Stash
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'
alias gstu='git stash push --include-untracked'
alias gstall='git stash --all'

# Switch (modern checkout for branches)
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch main'
alias gswd='git switch develop'

# Submodule
alias gsu='git submodule update'
alias gsui='git submodule update --init'
alias gsuir='git submodule update --init --recursive'

# Show
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'

# Tags
alias gts='git tag --sign'
alias gtv='git tag | sort -V'

# Worktree
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'

# Misc
alias gcount='git shortlog --summary --numbered'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm (git ls-files --deleted) 2>/dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gunwip='git rev-parse --verify --quiet "HEAD^{commit}" >/dev/null && git log -n 1 --pretty=format:"%s" HEAD | grep -q "^--wip--" && git reset HEAD~1'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'

# -----------------------------------------------------------------------------
# Functions (more complex operations)
# -----------------------------------------------------------------------------

# Current branch
function gcb --description "Get current branch name"
    git branch --show-current
end

# Delete merged branches
function gbda --description "Delete merged branches"
    git branch --no-color --merged | command grep -vE "^([+*]|\s*(main|master|develop|dev)\s*\$)" | command xargs git branch --delete 2>/dev/null
end

# Fancy diff with fzf (if available)
if command -q fzf
    function gfzf --description "Interactive git log with fzf"
        git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv | \
        fzf --ansi --no-sort --reverse --tiebreak=index \
            --preview 'git show --color=always (echo {} | grep -o "[a-f0-9]\{7,\}" | head -1)' \
            --bind "enter:execute:git show --color=always (echo {} | grep -o '[a-f0-9]\{7,\}' | head -1) | less -R"
    end
end

# Undo last commit but keep changes
function gundo --description "Undo last commit, keep changes staged"
    git reset --soft HEAD~1
end

# Amend without editing message
function gamend --description "Amend last commit without editing"
    git commit --amend --no-edit
end
