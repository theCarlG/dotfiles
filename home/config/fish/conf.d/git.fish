# Fish git abbreviations (oh-my-zsh git plugin style)
# Save to: ~/.config/fish/conf.d/git.fish

if not command -q git
    return
end

# Git base
abbr -a g git

# Add
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gapa 'git add --patch'
abbr -a gau 'git add --update'
abbr -a gav 'git add --verbose'

# Branch
abbr -a gb 'git branch'
abbr -a gba 'git branch --all'
abbr -a gbd 'git branch --delete'
abbr -a gbD 'git branch --delete --force'
abbr -a gbl 'git blame -w'
abbr -a gbnm 'git branch --no-merged'
abbr -a gbr 'git branch --remote'
abbr -a gbs 'git bisect'
abbr -a gbsb 'git bisect bad'
abbr -a gbsg 'git bisect good'
abbr -a gbsr 'git bisect reset'
abbr -a gbss 'git bisect start'

# Commit
abbr -a gc 'git commit --verbose'
abbr -a gc! 'git commit --verbose --amend'
abbr -a gcn! 'git commit --verbose --no-edit --amend'
abbr -a gca 'git commit --verbose --all'
abbr -a gca! 'git commit --verbose --all --amend'
abbr -a gcan! 'git commit --verbose --all --no-edit --amend'
abbr -a gcann! 'git commit --verbose --all --date=now --no-edit --amend'
abbr -a gcans! 'git commit --verbose --all --signoff --no-edit --amend'
abbr -a gcam 'git commit --all --message'
abbr -a gcsm 'git commit --signoff --message'
abbr -a gcas 'git commit --all --signoff'
abbr -a gcasm 'git commit --all --signoff --message'
abbr -a gcmsg 'git commit --message'
abbr -a gcs 'git commit --gpg-sign'
abbr -a gcss 'git commit --gpg-sign --signoff'
abbr -a gcssm 'git commit --gpg-sign --signoff --message'

# Checkout
abbr -a gco 'git checkout'
abbr -a gcob 'git checkout -b'
abbr -a gcom 'git checkout main'
abbr -a gcor 'git checkout --recurse-submodules'

# Cherry-pick
abbr -a gcp 'git cherry-pick'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'

# Clone
abbr -a gcl 'git clone --recurse-submodules'

# Clean
abbr -a gclean 'git clean --interactive -d'
abbr -a gpristine 'git reset --hard && git clean --force -dfx'

# Diff
abbr -a gd 'git diff'
abbr -a gdca 'git diff --cached'
abbr -a gdcw 'git diff --cached --word-diff'
abbr -a gds 'git diff --staged'
abbr -a gdw 'git diff --word-diff'
abbr -a gdup 'git diff @{upstream}'
abbr -a gdnolock 'git diff -- ":(exclude)Cargo.lock" ":(exclude)package-lock.json"'

# Fetch
abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all --prune --jobs=10'
abbr -a gfo 'git fetch origin'

# Log
abbr -a glg 'git log --stat'
abbr -a glgp 'git log --stat --patch'
abbr -a glgg 'git log --graph'
abbr -a glgga 'git log --graph --decorate --all'
abbr -a glgm 'git log --graph --max-count=10'
abbr -a glo 'git log --oneline --decorate'
abbr -a glol 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
abbr -a glols 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
abbr -a glod 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
abbr -a glods 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
abbr -a glola 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
abbr -a glog 'git log --oneline --decorate --graph'
abbr -a gloga 'git log --oneline --decorate --graph --all'

# Merge
abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmc 'git merge --continue'
abbr -a gms 'git merge --squash'
abbr -a gmom 'git merge origin/main'
abbr -a gmum 'git merge upstream/main'

# Push
abbr -a gp 'git push'
abbr -a gpd 'git push --dry-run'
abbr -a gpf 'git push --force-with-lease --force-if-includes'
abbr -a gpf! 'git push --force'
abbr -a gpoat 'git push origin --all && git push origin --tags'
abbr -a gpod 'git push origin --delete'
abbr -a gpr 'git pull --rebase'
abbr -a gpu 'git push upstream'
abbr -a gpv 'git push --verbose'

# Pull
abbr -a gl 'git pull'
abbr -a gpr 'git pull --rebase'
abbr -a gprv 'git pull --rebase --verbose'
abbr -a gpra 'git pull --rebase --autostash'
abbr -a gprav 'git pull --rebase --autostash --verbose'
abbr -a gprom 'git pull --rebase origin main'
abbr -a gpromi 'git pull --rebase=interactive origin main'
abbr -a ggpull 'git pull origin (git branch --show-current)'

# Push current branch
abbr -a ggpush 'git push origin (git branch --show-current)'
abbr -a gpsup 'git push --set-upstream origin (git branch --show-current)'

# Rebase
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase --interactive'
abbr -a grbo 'git rebase --onto'
abbr -a grbs 'git rebase --skip'
abbr -a grbom 'git rebase origin/main'
abbr -a grbum 'git rebase upstream/main'

# Remote
abbr -a gr 'git remote'
abbr -a gra 'git remote add'
abbr -a grv 'git remote --verbose'
abbr -a grmv 'git remote rename'
abbr -a grrm 'git remote remove'
abbr -a grset 'git remote set-url'
abbr -a grup 'git remote update'

# Reset
abbr -a grh 'git reset'
abbr -a grhh 'git reset --hard'
abbr -a grhk 'git reset --keep'
abbr -a grhs 'git reset --soft'
abbr -a grhu 'git reset --hard @{upstream}'
abbr -a gru 'git reset --'

# Restore
abbr -a grs 'git restore'
abbr -a grss 'git restore --source'
abbr -a grst 'git restore --staged'

# Revert
abbr -a grev 'git revert'
abbr -a greva 'git revert --abort'
abbr -a grevc 'git revert --continue'

# Remove
abbr -a grm 'git rm'
abbr -a grmc 'git rm --cached'

# Status
abbr -a gst 'git status'
abbr -a gss 'git status --short'
abbr -a gsb 'git status --short --branch'

# Stash
abbr -a gsta 'git stash push'
abbr -a gstaa 'git stash apply'
abbr -a gstc 'git stash clear'
abbr -a gstd 'git stash drop'
abbr -a gstl 'git stash list'
abbr -a gstp 'git stash pop'
abbr -a gsts 'git stash show --patch'
abbr -a gstu 'git stash push --include-untracked'
abbr -a gstall 'git stash --all'

# Switch (modern checkout for branches)
abbr -a gsw 'git switch'
abbr -a gswc 'git switch --create'
abbr -a gswm 'git switch main'
abbr -a gswd 'git switch develop'

# Submodule
abbr -a gsu 'git submodule update'
abbr -a gsui 'git submodule update --init'
abbr -a gsuir 'git submodule update --init --recursive'

# Show
abbr -a gsh 'git show'
abbr -a gsps 'git show --pretty=short --show-signature'

# Tags
abbr -a gts 'git tag --sign'
abbr -a gtv 'git tag | sort -V'

# Worktree
abbr -a gwt 'git worktree'
abbr -a gwta 'git worktree add'
abbr -a gwtls 'git worktree list'
abbr -a gwtmv 'git worktree move'
abbr -a gwtrm 'git worktree remove'

# Misc
abbr -a gcount 'git shortlog --summary --numbered'
abbr -a gwch 'git whatchanged -p --abbrev-commit --pretty=medium'
abbr -a gwip 'git add -A; git rm (git ls-files --deleted) 2>/dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
abbr -a gunwip 'git rev-parse --verify --quiet "HEAD^{commit}" >/dev/null && git log -n 1 --pretty=format:"%s" HEAD | grep -q "^--wip--" && git reset HEAD~1'
abbr -a gignore 'git update-index --assume-unchanged'
abbr -a gunignore 'git update-index --no-assume-unchanged'
abbr -a gignored 'git ls-files -v | grep "^[[:lower:]]"'

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
