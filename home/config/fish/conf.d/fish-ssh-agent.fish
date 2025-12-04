# Agent key lifetime (default: 128 hours = 460800 seconds)
set -g __ssh_agent_lifetime 460800

# Enable agent forwarding in SSH config
set -g __ssh_agent_forwarding yes

# Keys to auto-add (leave empty to add default key, or specify paths)
# Example: set -g __ssh_agent_identities ~/.ssh/id_ed25519 ~/.ssh/id_work
set -g __ssh_agent_identities

# -----------------------------------------------------------------------------
# SSH_ASKPASS helper (ksshaskpass, ssh-askpass, etc.)
# -----------------------------------------------------------------------------

if test -z "$SSH_ASKPASS"
    if command -q ksshaskpass
        set -gx SSH_ASKPASS (command -v ksshaskpass)
        set -gx SSH_ASKPASS_REQUIRE prefer
    else if command -q ssh-askpass
        set -gx SSH_ASKPASS (command -v ssh-askpass)
        set -gx SSH_ASKPASS_REQUIRE prefer
    else if command -q /usr/lib/ssh/x11-ssh-askpass
        set -gx SSH_ASKPASS /usr/lib/ssh/x11-ssh-askpass
        set -gx SSH_ASKPASS_REQUIRE prefer
    else if test -n "$DISPLAY" -a -x /usr/lib/openssh/gnome-ssh-askpass
        set -gx SSH_ASKPASS /usr/lib/openssh/gnome-ssh-askpass
        set -gx SSH_ASKPASS_REQUIRE prefer
    end
end

# -----------------------------------------------------------------------------
# Agent management
# -----------------------------------------------------------------------------

set -g __ssh_agent_env_file $HOME/.ssh/agent.env.fish

function __ssh_agent_is_running
    if test -z "$SSH_AGENT_PID"
        return 1
    end
    ps -p $SSH_AGENT_PID -o comm= 2>/dev/null | grep -q ssh-agent
end

function __ssh_agent_load_env
    if test -f $__ssh_agent_env_file
        source $__ssh_agent_env_file >/dev/null
    end
end

function __ssh_agent_save_env
    echo "set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK" >$__ssh_agent_env_file
    echo "set -gx SSH_AGENT_PID $SSH_AGENT_PID" >>$__ssh_agent_env_file
    chmod 600 $__ssh_agent_env_file
end

function __ssh_agent_start
    # Start agent with specified lifetime
    eval (ssh-agent -c -t $__ssh_agent_lifetime) >/dev/null
    __ssh_agent_save_env
end

function __ssh_agent_add_keys
    # Check if any keys are already added
    ssh-add -l >/dev/null 2>&1
    set -l status_code $status

    # 0 = keys present, 1 = no keys, 2 = can't connect
    if test $status_code -eq 2
        return 1
    end

    if test $status_code -eq 1
        # No keys added, add them
        if test -n "$__ssh_agent_identities"
            # Add specified keys
            for key in $__ssh_agent_identities
                if test -f $key
                    ssh-add -t $__ssh_agent_lifetime $key 2>/dev/null
                end
            end
        else
            # Add default keys
            ssh-add -t $__ssh_agent_lifetime 2>/dev/null
        end
    end
end

# -----------------------------------------------------------------------------
# Agent forwarding configuration
# -----------------------------------------------------------------------------

function __ssh_agent_setup_forwarding
    if test "$__ssh_agent_forwarding" = yes
        # Ensure ~/.ssh/config exists and has forwarding enabled
        set -l ssh_config $HOME/.ssh/config

        if not test -f $ssh_config
            mkdir -p $HOME/.ssh
            touch $ssh_config
            chmod 600 $ssh_config
        end

        # Check if ForwardAgent is already configured globally
        if not grep -q "^Host \*" $ssh_config 2>/dev/null || not grep -q "ForwardAgent yes" $ssh_config 2>/dev/null
            # Set SSH_AUTH_SOCK for forwarding (already set by agent)
            # The actual forwarding is controlled by ssh_config or -A flag
            :
        end
    end
end

# -----------------------------------------------------------------------------
# Initialization
# -----------------------------------------------------------------------------

function __ssh_agent_init
    # Skip if not interactive
    if not status is-interactive
        return
    end

    # Skip if SSH_AUTH_SOCK is already set (e.g., by systemd user service)
    # But still check if it's valid
    if test -n "$SSH_AUTH_SOCK"
        if test -S "$SSH_AUTH_SOCK"
            # Socket exists, try to use it
            ssh-add -l >/dev/null 2>&1
            if test $status -ne 2
                # Agent is accessible
                __ssh_agent_add_keys
                __ssh_agent_setup_forwarding
                return
            end
        end
    end

    # Try to load existing agent env
    __ssh_agent_load_env

    if not __ssh_agent_is_running
        # Start new agent
        __ssh_agent_start
    else
        # Verify socket is still valid
        if not test -S "$SSH_AUTH_SOCK"
            __ssh_agent_start
        end
    end

    __ssh_agent_add_keys
    __ssh_agent_setup_forwarding
end

# Run initialization
__ssh_agent_init

# -----------------------------------------------------------------------------
# Utility functions
# -----------------------------------------------------------------------------

function ssh-agent-restart --description "Restart ssh-agent"
    # Kill existing agent
    if test -n "$SSH_AGENT_PID"
        kill $SSH_AGENT_PID 2>/dev/null
    end
    
    # Remove env file
    rm -f $__ssh_agent_env_file
    
    # Clear variables
    set -e SSH_AUTH_SOCK
    set -e SSH_AGENT_PID
    
    # Start fresh
    __ssh_agent_start
    __ssh_agent_add_keys
    
    echo "ssh-agent restarted (PID: $SSH_AGENT_PID)"
end

function ssh-agent-status --description "Show ssh-agent status"
    echo "SSH_AGENT_PID: $SSH_AGENT_PID"
    echo "SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
    echo "SSH_ASKPASS:   $SSH_ASKPASS"
    echo ""
    
    if __ssh_agent_is_running
        echo "Agent status: running"
        echo ""
        echo "Loaded keys:"
        ssh-add -l
    else
        echo "Agent status: not running"
    end
end

function ssh-add-all --description "Add all keys in ~/.ssh"
    for key in $HOME/.ssh/id_* 
        if test -f $key -a ! -f $key.pub -a (string match -qv "*.pub" $key)
            # Skip if it's a .pub file or doesn't exist
            continue
        end
        if test -f $key -a (string match -qv "*.pub" $key)
            echo "Adding $key"
            ssh-add -t $__ssh_agent_lifetime $key
        end
    end
end

# Alias for agent forwarding SSH
if test "$__ssh_agent_forwarding" = yes
    abbr -a ssha 'ssh -A'
end
