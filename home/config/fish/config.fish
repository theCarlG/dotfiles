# Fish shell configuration
# Converted from oh-my-zsh zshrc

# Editor
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim

# Disable greeting
set -g fish_greeting

# -----------------------------------------------------------------------------
# Path setup
# -----------------------------------------------------------------------------

# Local bin
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin

set -g __ssh_agent_lifetime 460800
set -g __ssh_agent_forwarding yes

# Cargo/Rust
if test -d $HOME/.cargo
    fish_add_path $HOME/.cargo/bin

    abbr -a ca cargo

    # Mold linker (prefer wild if available, otherwise mold)
    if command -q wild
        set -l WILD_PATH (command -v wild)
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER clang
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS "-Clink-args=--ld-path=$WILD_PATH"
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER clang
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_RUSTFLAGS "-Clink-args=--ld-path=$WILD_PATH"
    else if command -q mold
        set -l MOLD_PATH (command -v mold)
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER clang
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS "-C link-arg=-fuse-ld=$MOLD_PATH -Clink-arg=-Wl,--no-rosegment"
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER clang
        set -gx CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_RUSTFLAGS "-C link-arg=-fuse-ld=$MOLD_PATH -Clink-arg=-Wl,--no-rosegment"
    end

    # sccache
    if command -q sccache
        set -gx SCCACHE_IGNORE_SERVER_IO_ERROR 1
        set -gx RUSTC_WRAPPER (command -v sccache)
    end
end

# Go
if test -d /usr/local/go/bin
    set -gx GOPATH $HOME/.go
    set -gx GOBIN $GOPATH/bin
    fish_add_path $GOBIN /usr/local/go/bin
end

# Wasmtime
if test -d $HOME/.wasmtime
    set -gx WASMTIME_HOME $HOME/.wasmtime
    fish_add_path $WASMTIME_HOME/bin
end

# -----------------------------------------------------------------------------
# Tmux helper function
# -----------------------------------------------------------------------------

function tm --description "Attach to or create tmux session"
    if test -z "$argv[1]"
        echo "usage: tm <session>" >&2
        return 1
    end
    if tmux has-session -t $argv[1] 2>/dev/null
        tmux attach-session -t $argv[1]
    else
        tmux new-session -s $argv[1]
    end
end

# Tmux session completion
function __fish_tm_sessions
    tmux list-sessions -F "#{session_name}" 2>/dev/null
end

complete -c tm -f -a "(__fish_tm_sessions)"

# -----------------------------------------------------------------------------
# Tool aliases/abbreviations
# -----------------------------------------------------------------------------

# eza (modern ls replacement)
if command -q eza
    alias ls 'eza --sort=type'
    alias l 'eza -lbG --git --sort=type'
    alias ll 'eza -lbF --git --sort=type'
    alias llm 'eza -lbF --git --sort=modified'
    alias la 'eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --sort=type'
    alias lx 'eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --sort=type'
    alias lS 'eza -1 --sort=type'
    alias lt 'eza --tree --level=2 --sort=type'
end

# ripgrep
if command -q rg
    alias grep rg
end

# bat
if command -q bat
    alias cat bat

    function batdiff --description "Show git diff with bat"
        if git rev-parse --git-dir >/dev/null 2>&1
            git diff --name-only --diff-filter=d | xargs bat --diff
        end
    end
end

# -----------------------------------------------------------------------------
# Prompt (starship)
# -----------------------------------------------------------------------------

if command -q starship
    starship init fish | source
end

# -----------------------------------------------------------------------------
# Local overrides
# -----------------------------------------------------------------------------

# Source local config if it exists (pre)
test -f $HOME/.config/fish/local.fish; and source $HOME/.config/fish/local.fish
