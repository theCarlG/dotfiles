# Fish rsync abbreviations (oh-my-zsh rsync plugin style)
# Save to: ~/.config/fish/conf.d/rsync.fish

if not command -q rsync
    return
end

# -----------------------------------------------------------------------------
# Core rsync aliases from oh-my-zsh
# -----------------------------------------------------------------------------

# Default rsync with progress and human-readable
abbr -a rsync-copy 'rsync -avh --progress'
abbr -a rsync-move 'rsync -avh --progress --remove-source-files'
abbr -a rsync-update 'rsync -avhu --progress'
abbr -a rsync-sync 'rsync -avhu --delete --progress'

# Short versions
abbr -a rcp 'rsync -avh --progress'
abbr -a rmv 'rsync -avh --progress --remove-source-files'
abbr -a rup 'rsync -avhu --progress'
abbr -a rsy 'rsync -avhu --delete --progress'

# -----------------------------------------------------------------------------
# Extended aliases
# -----------------------------------------------------------------------------

# Dry run versions (preview what would happen)
abbr -a rsync-copy-dry 'rsync -avhn --progress'
abbr -a rsync-move-dry 'rsync -avhn --progress --remove-source-files'
abbr -a rsync-update-dry 'rsync -avhun --progress'
abbr -a rsync-sync-dry 'rsync -avhun --delete --progress'

abbr -a rcpd 'rsync -avhn --progress'
abbr -a rmvd 'rsync -avhn --progress --remove-source-files'
abbr -a rupd 'rsync -avhun --progress'
abbr -a rsyd 'rsync -avhun --delete --progress'

# With compression (good for remote transfers)
abbr -a rsync-copy-z 'rsync -avhz --progress'
abbr -a rsync-move-z 'rsync -avhz --progress --remove-source-files'
abbr -a rsync-update-z 'rsync -avhuz --progress'
abbr -a rsync-sync-z 'rsync -avhuz --delete --progress'

abbr -a rcpz 'rsync -avhz --progress'
abbr -a rmvz 'rsync -avhz --progress --remove-source-files'
abbr -a rupz 'rsync -avhuz --progress'
abbr -a rsyz 'rsync -avhuz --delete --progress'

# Partial transfers (resume interrupted transfers)
abbr -a rsync-resume 'rsync -avhP'
abbr -a rrs 'rsync -avhP'

# With checksum verification (slower but safer)
abbr -a rsync-checksum 'rsync -avhc --progress'
abbr -a rck 'rsync -avhc --progress'

# Backup with timestamp suffix
abbr -a rsync-backup 'rsync -avhb --backup-dir=backup_$(date +%Y%m%d_%H%M%S) --progress'
abbr -a rbk 'rsync -avhb --progress'

# Exclude common junk
abbr -a rsync-clean 'rsync -avh --progress --exclude="*.tmp" --exclude="*.log" --exclude=".DS_Store" --exclude="Thumbs.db" --exclude=".git" --exclude="node_modules" --exclude="target" --exclude="__pycache__"'
abbr -a rcl 'rsync -avh --progress --exclude="*.tmp" --exclude="*.log" --exclude=".DS_Store" --exclude="Thumbs.db" --exclude=".git" --exclude="node_modules" --exclude="target" --exclude="__pycache__"'

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

# Interactive rsync with confirmation
function rsync-confirm --description "Rsync with dry-run preview and confirmation"
    if test (count $argv) -lt 2
        echo "Usage: rsync-confirm [rsync-options] source destination" >&2
        return 1
    end

    echo "=== DRY RUN ===" 
    rsync -avhn --progress $argv
    echo ""
    
    read -l -P "Proceed with sync? [y/N] " confirm
    if test "$confirm" = y -o "$confirm" = Y
        rsync -avh --progress $argv
    else
        echo "Cancelled."
    end
end

# Sync with delete (dangerous, so requires confirmation)
function rsync-mirror --description "Mirror directories (with delete, requires confirmation)"
    if test (count $argv) -lt 2
        echo "Usage: rsync-mirror source destination" >&2
        return 1
    end

    set -l src $argv[1]
    set -l dst $argv[2]
    set -l extra $argv[3..-1]

    echo "⚠️  WARNING: This will DELETE files in destination that don't exist in source!"
    echo "Source:      $src"
    echo "Destination: $dst"
    echo ""
    echo "=== Files that would be DELETED ===" 
    rsync -avhn --delete $extra $src $dst 2>/dev/null | grep "^deleting "
    echo ""
    echo "=== DRY RUN ===" 
    rsync -avhn --delete --progress $extra $src $dst
    echo ""
    
    read -l -P "Proceed with mirror sync? Type 'yes' to confirm: " confirm
    if test "$confirm" = yes
        rsync -avh --delete --progress $extra $src $dst
    else
        echo "Cancelled."
    end
end

# Compare two directories
function rsync-diff --description "Show differences between two directories"
    if test (count $argv) -lt 2
        echo "Usage: rsync-diff dir1 dir2" >&2
        return 1
    end

    set -l src $argv[1]
    set -l dst $argv[2]

    echo "=== Files only in $src ===" 
    rsync -avhn --ignore-existing $src $dst | grep -v "^sending\|^sent\|^total\|^\$"
    echo ""
    echo "=== Files only in $dst ===" 
    rsync -avhn --ignore-existing $dst $src | grep -v "^sending\|^sent\|^total\|^\$"
    echo ""
    echo "=== Files that differ ===" 
    rsync -avhcn --existing $src $dst | grep -v "^sending\|^sent\|^total\|^\$"
end

# Rsync over SSH with specific port
function rsync-ssh --description "Rsync over SSH with custom port"
    if test (count $argv) -lt 3
        echo "Usage: rsync-ssh port source destination" >&2
        return 1
    end

    set -l port $argv[1]
    set -l src $argv[2]
    set -l dst $argv[3]
    set -l extra $argv[4..-1]

    rsync -avhz --progress -e "ssh -p $port" $extra $src $dst
end

# Bandwidth limited rsync (in KB/s)
function rsync-limit --description "Rsync with bandwidth limit"
    if test (count $argv) -lt 3
        echo "Usage: rsync-limit <limit-kb/s> source destination" >&2
        return 1
    end

    set -l limit $argv[1]
    set -l src $argv[2]
    set -l dst $argv[3]
    set -l extra $argv[4..-1]

    rsync -avhz --progress --bwlimit=$limit $extra $src $dst
end

# Quick local backup
function rsync-snap --description "Create timestamped backup snapshot"
    if test (count $argv) -lt 2
        echo "Usage: rsync-snap source backup-base-dir" >&2
        return 1
    end

    set -l src $argv[1]
    set -l base $argv[2]
    set -l timestamp (date +%Y%m%d_%H%M%S)
    set -l dst "$base/$timestamp"

    mkdir -p $dst
    rsync -avh --progress $src $dst
    echo "Backup created: $dst"
end

# Incremental backup with hard links (like Time Machine)
function rsync-incremental --description "Incremental backup with hard links to previous"
    if test (count $argv) -lt 2
        echo "Usage: rsync-incremental source backup-base-dir" >&2
        return 1
    end

    set -l src $argv[1]
    set -l base $argv[2]
    set -l timestamp (date +%Y%m%d_%H%M%S)
    set -l dst "$base/$timestamp"
    set -l latest "$base/latest"

    mkdir -p $base

    if test -L $latest
        set -l prev (readlink -f $latest)
        echo "Creating incremental backup (linking unchanged files to $prev)"
        rsync -avh --progress --link-dest=$prev $src $dst
    else
        echo "Creating initial backup"
        rsync -avh --progress $src $dst
    end

    # Update 'latest' symlink
    rm -f $latest
    ln -s $dst $latest
    echo "Backup created: $dst"
    echo "Latest link updated: $latest"
end
