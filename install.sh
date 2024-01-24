#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_DIR=`pwd`
OS_TYPE=$(uname)

C_R="\e[1;31m"
C_G="\e[1;32m"
C_B="\e[1;34m"
C_Y="\e[1;33m"
C_NC="\e[0m"
B="\e[1m"
I="\e[3m"
U="\e[4m"

if [ $(echo $TERM | grep 256 | wc -l) -eq 0 ]; then
    C_R=""
    C_G=""
    C_B=""
    C_Y=""
    C_NC=""
    B=""
fi

echo -e "$B"
echo '_________              .__    ________              '
echo '\_   ___ \_____ _______|  |  /  _____/              '
echo '/    \  \/\__  \\_  __ \  | /   \  ___              '
echo '\     \____/ __ \|  | \/  |_\    \_\  \             '
echo ' \______  (____  /__|  |____/\______  /             '
echo '        \/     \/                   \/              '
echo '________          __    _____.__.__                 '
echo '\______ \   _____/  |__/ ____\__|  |   ____   ______'
echo ' |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/'
echo ' |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ '
echo '/_______  /\____/|__|  |__|  |__|____/\___  >____  >'
echo '        \/                                \/     \/ '
echo -e "$C_NC"

echo -e "$B* Looking for required binaries$C_NC"
for b in git curl; do
    echo -n "  $b: "
    command -v $b &> /dev/null && echo -e "${C_G}installed$C_NC" || ( echo -e "$b: ${C_R}not installed$C_NC"; exit 1 )
done
echo ""

function link_file {
    file=$(basename $2)
    if [ -L $2 ]; then
        echo -e "$C_Y  Symlink $2 exists$C_NC"
    elif [ -d $2 ]; then
        echo -e "$C_R  Dir $2 exists$C_NC"
    elif [ -f $2 ]; then
        echo -e "$C_R  File $2 exists$C_NC"
    elif [ ! -L $2 ]; then
        echo -e "$C_G  Symlinking $file$C_NC"
        ln -s $1 $2
    fi
}

echo -e "$B* Looking for required tools$C_NC"

echo -n "  oh-my-zsh: "
test ! -d  $HOME/.oh-my-zsh && {
    echo -e "${C_Y}not installed$C_NC"
    curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    test -L $HOME/.zshrc || rm $HOME/.zshrc
} || {
    echo -e "${C_G}installed$C_NC"
}

echo -n "  rustup: "
test ! command -v rustup &> /dev/null && {
    echo -e "${C_Y}not installed$C_NC"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup component add rust-src
    rustup component add clippy rustfmt
} || {
    echo -e "${C_G}installed$C_NC"
}

echo -n "  tmux tpm: "
test ! -d  $HOME/.tmux/plugins/tpm && {
    echo -e "${C_Y}not installed$C_NC"
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
} || {
    echo -e "${C_G}installed$C_NC"
}

echo -e "$B* Looking for recommended binaries$C_NC"
for b in nvim tmux zsh gpg ; do
    echo -n "  $b: "
    command -v $b &> /dev/null && echo -e "${C_G}installed$C_NC" || echo -e "${C_R}not installed$C_NC"
done

echo -n "  wasmtime: "
test ! -d $HOME/.wasmtime && {
    echo -e "${C_R}not installed$C_NC"
    curl https://wasmtime.dev/install.sh -sSf | bash
    rustup target add wasm32-wasi
    cargo install cargo-wasi
} || {
    echo -e "${C_G}installed$C_NC"
}

echo ""

echo -e "$B* Looking for rust tools$C_NC"
while IFS=, read -r name bin; do
    echo -n "  $name: "
    ! command -v $bin &> /dev/null && {
        echo -e "${C_Y}not installed$C_NC"
        cargo install $name
    } || {
        echo -e "${C_G}installed$C_NC"
    }
done << EOL
eza,eza
ripgrep,rg
hyperfine,hyperfine
bat,bat
jless,jless
tokei,tokei
htmlq,htmlq
cargo-update,cargo-install-update
topgrade,topgrade
cargo-watch,cargo-watch
cargo-insta,cargo-insta
cargo-sweep,cargo-sweep
cargo-cranky,cargo-cranky
du-dust,dust
bottom,btm
difftastic,difft
fd-find,fd
EOL

echo ""

COMMON=(
config/nvim
config/tmux
config/alacritty
config/mutt
config/nushell
gitconfig
psqlrc
zshrc
cargo/config.toml
)

BIN=$(ls $DIR/bin)

LINUX=(
config/systemd
config/topgrade.toml
zshrc.platform
)

command -v Hyprland &> /dev/null && LINUX+=(config/hypr)
command -v swaylock &> /dev/null && LINUX+=(config/swaylock)
command -v swaync &> /dev/null && LINUX+=(config/swaync)
command -v waybar &> /dev/null && LINUX+=(config/waybar)

cd $CURRENT_DIR

test ! -d $HOME/.cargo && mkdir $HOME/.cargo

if [ ! -d $HOME/.config ]; then
    echo "** Creating ~/.config/"
    mkdir -p $HOME/.config
    echo ""
fi

echo "* Linking common files"
for file in ${COMMON[@]}; do
    link_file $DIR/common/$file $HOME/.$file
done
echo ""

if [ "$OS_TYPE" == "Linux" ]; then
    echo "* Linking Linux specific configs"
    for file in ${LINUX[@]}; do
        link_file $DIR/linux/$file $HOME/.$file
    done
    echo ""
fi

if [ ! -d $HOME/.local/bin ]; then
    echo "* Creating ~/.local/bin/"
    mkdir -p $HOME/.local/bin
    echo ""
fi

echo "* Linking scripts"
for file in ${BIN[@]}; do
    link_file $DIR/bin/$file $HOME/.local/bin/$file
done
echo ""

IFS='
'
echo "* Looking for broken symlinks in home directory"
for l in $(find $HOME -maxdepth 3 -type l -exec file {} \; | grep -v 'snap' | grep broken | cut -d\  -f1,6); do
    echo -e "${C_R}  $l$C_NC"
done
unset IFS
