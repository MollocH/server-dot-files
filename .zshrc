# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export MACHINE_ARCH=$(uname -m)

#
# User configuration sourced by interactive shells
#
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=${HISTSIZE}
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

export MYSQL_PS1="\R:\m:\s - \u@\h [\d]> "

export BAT_THEME="base16"

export PATH="${HOME}/.local/bin:${PATH}"
export PATH=${PATH}:${HOME}/.arkade/bin/
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"

export GOPATH=${HOME}/go

export GPG_TTY=$(tty)

export EDITOR='vim'

#set zsh to emacs mode
bindkey -e
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

alias vi="vim"
alias ag="ag --pager \"less -R\""
alias psgr="ps -ef | grep -v grep | grep"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias tf="tail -f"
alias tfn="tail -f -n0"
alias mux="tmuxinator"
alias ms="mux start"
alias grep="grep -v grep | grep"
alias rm="rm -iv"
alias mv="mv -iv"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias ttfb="curl -L -s -w '\nLookup time:\t%{time_namelookup}\nConnect time:\t%{time_connect}\nAppCon time:\t%{time_appconnect}\nRedirect time:\t%{time_redirect}\nPreXfer time:\t%{time_pretransfer}\nStartXfer time:\t%{time_starttransfer}\n\nTotal time:\t%{time_total}\n' -o /dev/null"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dinspec='docker run -it --rm -v $(pwd):/share chef/inspec'
alias checkssldate='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -dates };f'
alias rmkh='f() { sed -i.bak -e '${1}d' /home/hannes/.ssh/known_hosts };f'
alias ip="ip -c"
alias ipb="ip -br"
alias octperm="stat -c \"%a %n\""
alias sshp="ssh -o PreferredAuthentications=password"
alias less="less -R"
alias lsd="lsd --icon=never"
alias ls="exa --time-style=long-iso --git -g"
export FZF_DEFAULT_COMMAND="fd . ${HOME}"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd -t d . ${HOME}"
alias checkssl='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -text -noout };f'
alias checkssldate='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -dates };f'
alias checksslsubject='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -subject };f'
alias checksslcert_local_date='f() { openssl x509 -in $1 -text -noout | grep -i after 2>/dev/null};f'
alias checksslcert_local='f() { openssl x509 -in $1 -text -noout 2>/dev/null};f'
alias glb="git branch -r --sort=-committerdate --format='%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' --color=always | column -ts'|'"

## Functions
function petpre() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function rgl() {
  rg -p "$@" | less -XFR
}

function backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}

function mysqlpwhash() {
    echo -n "${@}" | openssl sha1 -binary | openssl sha1 -hex | sed 's/^.* //' | awk '{print "*"toupper($0)}'
}



zle -N backward-kill-dir


if [[ ! -d "/${HOME}/.local/share/zinit/zinit.git" ]]; then
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  mkdir -p "$(dirname ${ZINIT_HOME})"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
  if [[ -d "/${HOME}/.zinit/bin" ]]; then
    rm -rf "/${HOME}/.zinit/bin"
  fi
  source "${ZINIT_HOME}/zinit.zsh"
fi
if [[ ! -d "/${HOME}/.asdf" ]]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
    autoload -Uz compinit && compinit
    . ${HOME}/.asdf/asdf.sh
    asdf update
#    asdf plugin-add rust
#    asdf plugin-add golang
#    asdf install rust 1.41.0
#    asdf install golang 1.13.7
#    asdf global rust 1.41.0
#    asdf global golang 1.13.7
fi

. ${HOME}/.asdf/asdf.sh

if [[ ! -d "/${HOME}/.krew" ]]; then
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
fi

### Install plug
if [[ ! -f "/${HOME}/.vim/autoload/plug.vim" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim "+:PlugInstall" "+:qall"
fi

##Install tmux plugin manager
if [[ ! -d "/${HOME}/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey "^W" backward-kill-dir

### Added by Zplugin's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk
# Two regular plugins loaded without tracking.
zinit light zsh-users/zsh-autosuggestions
zplg ice depth'1' blockf
zinit light zsh-users/zsh-completions

# Plugin history-search-multi-word loaded with tracking.
zinit load zdharma-continuum/history-search-multi-word

zinit ice depth=1; zinit light romkatv/powerlevel10k
## Load the pure theme, with zsh-async library that's bundled with it.
#zinit ice pick"async.zsh" src"pure.zsh"
#zinit light sindresorhus/pure

#zinit ice wait'!' lucid nocompletions \
#         compile"{zinc_functions/*,segments/*,zinc.zsh}" \
#         atload'!prompt_zinc_setup; prompt_zinc_precmd'
#zinit load robobenklein/zinc
#
## ZINC git info is already async, but if you want it
## even faster with gitstatus in Turbo mode:
## https://github.com/romkatv/gitstatus
#zinit ice wait'1' atload'zinc_optional_depenency_loaded'
#zinit load romkatv/gitstatus

# After finishing the configuration wizard change the atload'' ice to:
# -> atload'source ~/.p10k.zsh; _p9k_precmd'
# if [[ ! -f "/${HOME}/.p10k.zsh" ]]; then
#     zinit ice wait'!' lucid atload'true; _p9k_precmd' nocd
# else
#     zinit ice wait'!' lucid atload'source ~/.p10k.zsh; _p9k_precmd'
# fi
# zinit light romkatv/powerlevel10k

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin
setopt promptsubst

zinit ice wait lucid
zinit snippet OMZ::lib/git.zsh
zinit ice wait atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
#PS1="READY >" # provide a nice prompt till the theme loads
#zinit ice wait'!' lucid
#zinit snippet OMZ::themes/dstufft.zsh-theme
zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# include custom configs
if [[ -d ~/.zshrc-custom/ ]]
then
    for file in ~/.zshrc-custom/*; do
        source "${file}"
    done
fi

## programs
if [[ "${MACHINE_ARCH}" == "x86_64" ]];then
  # sharkdp/fd
  zinit ice as"command" from"gh-r" mv"fd* -> fd" bpick"*x86_64-unknown-linux-gnu*" pick"fd/fd"
  zinit light sharkdp/fd
  # sharkdp/bat
  zinit ice as"command" from"gh-r" mv"bat*/bat -> bat" pick"bat"
  zinit light sharkdp/bat
  # ogham/exa, replacement for ls
#  zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
  zinit ice as"command" from"gh-r" bpick"exa-linux-x86_64-musl-*" pick"bin/exa"
  zinit light ogham/exa
  # BurntSushi/ripgrep
  zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
  zinit light BurntSushi/ripgrep
  # b4b4r07/httpstat
  zinit ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
  zinit light b4b4r07/httpstat
  #dbrgn/tealdeer
  zinit ice as"command" from"gh-r" mv"tldr* -> tldr" bpick"tldr-linux-x86_64-musl" pick"tldr"
  zinit light dbrgn/tealdeer
  #derailed/k9s
  zinit ice as"command" from"gh-r" mv"k9s* -> k9s" bpick"*Linux_x86_64.tar.gz" pick"derailed/k9s"
  zinit light derailed/k9s
  #bootandy/dust
  zinit ice as"command" from"gh-r" mv"dust*unknown-linux-gnu/dust -> dust" pick"dust"
  zinit light bootandy/dust
  #cjbassi/ytop
  zinit ice as"command" from"gh-r" mv"ytop* -> ytop" pick"cjbassi/ytop"
  zinit light cjbassi/ytop
  #sharkdp/hyperfine
  zinit ice as"command" from"gh-r" mv"hyperfine*/hyperfine -> hyperfine" pick"sharkdp/hyperfine"
  zinit light sharkdp/hyperfine
  #pemistahl/grex
  zinit ice as"command" from"gh-r" mv"grex* -> grex" pick"pemistahl/grex"
  zinit light pemistahl/grex
  #imsnif/bandwhich
  zinit ice as"command" from"gh-r" mv"bandwhich* -> bandwhich" pick"imsnif/bandwhich"
  zinit light imsnif/bandwhich
  #chmln/sd
  zinit ice as"command" from"gh-r" mv"sd* -> sd" pick"sd"
  zinit light chmln/sd
  #dalance/procs
  zinit ice as"command" from"gh-r" mv"procs* -> procs" bpick"*lnx*"
  zinit light dalance/procs
  #dandavison/delta
  zinit ice as"command" from"gh-r" mv"*x86_64-unknown-linux-gnu/delta -> delta" bpick"*x86_64-unknown-linux-gnu*" pick"delta"
  zinit light dandavison/delta
  # ogham/dog
  zinit ice as"command" from"gh-r" bpick"*x86_64-unknown-linux-gnu*" pick"bin/dog"
  zinit light ogham/dog
  # knqyf263/pet
  zinit ice as"command" from"gh-r" bpick"pet_*_linux_amd64.tar.gz" pick"pet"
  zinit light knqyf263/pet
  # alexellis/arkade
  zinit ice as"command" from"gh-r" pick"arkade"
  zinit light alexellis/arkade
  # ellie/atuin
  zinit ice as"command" from"gh-r" mv"*x86_64-unknown-linux-gnu*/atuin* -> atuin" bpick"*x86_64-unknown-linux-gnu*" pick"atuin"
  zinit light ellie/atuin
  # akavel/up
  zinit ice as"command" from"gh-r"  pick"up"
  zinit light akavel/up
  # helix-editor/helix
  zinit ice as"command" from"gh-r" mv"*-x86_64-linux/hx -> hx" bpick"*-x86_64-linux.tar.xz" pick"hx"
  zinit light helix-editor/helix
  # sharkdp/vivid
  zinit ice as"command" from"gh-r" mv"*-x86_64-unknown-linux-gnu/vivid -> vivid" bpick"*-x86_64-unknown-linux-gnu.tar.gz" pick"vivid"
  zinit light sharkdp/vivid
  #Nukesor/pueue daemon
  zinit ice as"command" id-as"pueued" from"gh-r" bpick"pueued-linux-x86_64" mv"pueued-linux-x86_64 -> pueued" pick"pueued"
  zinit light Nukesor/pueue
  #Nukesor/pueue cli
  zinit ice as"command" id-as"pueue" from"gh-r" bpick"pueue-linux-x86_64" mv"pueue-linux-x86_64 -> pueue" pick"pueue"
  zinit light Nukesor/pueue
  #rhysd/hgrep
  zinit ice as"command" from"gh-r" mv"*x86_64-unknown-linux-gnu/hgrep -> hgrep" bpick"*-x86_64-unknown-linux-gnu*" pick"hgrep"
  zinit light rhysd/hgrep
  #FiloSottile/age
  zinit ice as"command" from"gh-r" bpick"*-linux-amd64.tar.gz" pick"age/(age|age-keygen)"
  zinit light FiloSottile/age
  #charmbracelet/glow
  zinit ice as"command" from"gh-r" bpick"*_linux_x86_64.tar.gz" pick"glow"
  zinit light charmbracelet/glow
  #mozilla/sops
  zinit ice as"command" from"gh-r" bpick"*.linux" mv"*.linux -> sops" pick"sops"
  zinit light mozilla/sops
  #Byron/dua-cli
  zinit ice as"command" from"gh-r" bpick"*x86_64-unknown-linux-musl.tar.gz" mv"*x86_64-unknown-linux-musl/dua-> dua" pick"dua"
  zinit light Byron/dua-cli
  #netxs-group/vtm
  zinit ice as"command" from"gh-r" bpick"vtm_linux_amd64.tar.gz" mv"vtm_linux_amd64/vtm-> vtm" pick"vtm"
  zinit light netxs-group/vtm
  #XAMPPRocky/tokei
  zinit ice as"command" from"gh-r" bpick"tokei-x86_64-unknown-linux-musl.tar.gz" pick"tokei"
  zinit light XAMPPRocky/tokei
  #veeso/termscp
  zinit ice as"command" from"gh-r" bpick"termscp-*-x86_64-unknown-linux-gnu.tar.gz" pick"termscp"
  zinit light veeso/termscp
  #zellij-org/zellij
  zinit ice as"command" from"gh-r" bpick"zellij-x86_64-unknown-linux-musl.tar.gz" pick"zellij"
  zinit light zellij-org/zellij
elif [[ "${MACHINE_ARCH}" == "aarch64" ]];then
#  # sharkdp/fd
#  zinit ice as"command" from"gh-r" mv"fd* -> fd" bpick"*arm-unknown-linux-gnu*" pick"fd/fd"
#  zinit light sharkdp/fd
#  # sharkdp/bat
#  zinit ice as"command" from"gh-r" mv"bat*/bat -> bat" bpick"*arm-unknown-linux-gnu*" pick"bat"
#  zinit light sharkdp/bat
  # BurntSushi/ripgrep
  zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" bpick"*arm-unknown-linux-gnu*" pick"ripgrep/rg"
  zinit light BurntSushi/ripgrep
  # b4b4r07/httpstat
  zinit ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
  zinit light b4b4r07/httpstat
  #dbrgn/tealdeer
  zinit ice as"command" from"gh-r" mv"tldr* -> tldr" bpick"tldr-linux-armv7-musleabihf" pick"dbrgn/tealdeer"
  zinit light dbrgn/tealdeer
  #derailed/k9s
  zinit ice as"command" from"gh-r" mv"k9s* -> k9s" bpick"k9s_Linux_arm64.tar.gz" pick"derailed/k9s"
  zinit light derailed/k9s
  #bootandy/dust
  zinit ice as"command" from"gh-r" mv"dust*unknown-linux-gnu/dust -> dust" bpick"arm-unknown-linux-gnueabihf*" pick"dust"
  zinit light bootandy/dust
  # helix-editor/helix
  zinit ice as"command" from"gh-r" mv"*-aarch64-linux/hx -> hx" bpick"*-aarch64-linux.tar.xz" pick"hx"
  zinit light helix-editor/helix
  #Nukesor/pueue daemon
  zinit ice as"command" id-as"pueued" from"gh-r" bpick"pueued-linux-aarch64" mv"pueued-linux-aarch64 -> pueued" pick"pueued"
  zinit light Nukesor/pueue
  #Nukesor/pueue cli
  zinit ice as"command" id-as"pueue" from"gh-r" bpick"pueue-linux-aarch64" mv"pueue-linux-aarch64 -> pueue" pick"pueue"
  zinit light Nukesor/pueue
  #charmbracelet/glow
  zinit ice as"command" from"gh-r" bpick"*_linux_arm64.tar.gz" pick"glow"
  zinit light charmbracelet/glow
  #Byron/dua-cli
  zinit ice as"command" from"gh-r" bpick"*arm-unknown-linux-gnueabihf.tar.gz" mv"*arm-unknown-linux-gnueabihf/dua-> dua" pick"dua"
  zinit light Byron/dua-cli
  #XAMPPRocky/tokei
  zinit ice as"command" from"gh-r" bpick"tokei-aarch64-unknown-linux-gnu.tar.gz" pick"tokei"
  zinit light XAMPPRocky/tokei
fi

if [[ "${MACHINE_ARCH}" == "x86_64" ]] && [[ "${ENV_CONTAINER_DEV}" == "yes" ]];then
  # aquasecurity/trivy
  zinit ice as"command" from"gh-r" bpick"trivy_*_Linux-64bit.tar.gz" pick"trivy"
  zinit light aquasecurity/trivy
  # anchore/syft
  zinit ice as"command" from"gh-r" bpick"*linux_amd64.tar.gz" pick"syft"
  zinit light anchore/syft
  # anchore/grype
  zinit ice as"command" from"gh-r" bpick"*linux_amd64.tar.gz" pick"grype"
  zinit light anchore/grype
  # vmware-tanzu/sonobuoy
  zinit ice as"command" from"gh-r" bpick"*_linux_amd64.tar.gz" pick"sonobuoy"
  zinit light vmware-tanzu/sonobuoy
  # bitnami-labs/sealed-secrets
  zinit ice as"command" from"gh-r" bpick"*-linux-amd64.tar.gz" pick"kubeseal"
  zinit light bitnami-labs/sealed-secrets
  # wagoodman/dive
  zinit ice as"command" from"gh-r" bpick"*_linux_amd64.tar.gz" pick"dive"
  zinit light wagoodman/dive
fi

if [[ "${MACHINE_ARCH}" == "x86_64" ]] && [[ "${ENV_AWS_OPS}" == "yes" ]];then
  #turbot/steampipe
  zinit ice as"command" from"gh-r" bpick"steampipe_linux_amd64.tar.gz" pick"steampipe"
  zinit light turbot/steampipe
fi

if [[ "${MACHINE_ARCH}" == "x86_64" ]] && [[ "${ENV_ARGO_DEV}" == "yes" ]];then
  # argoproj/argo-workflows
  zinit ice as"command" from"gh-r" bpick"*-linux-amd64.gz" mv"argo-linux-amd64 -> argo" pick"argo"
  zinit light argoproj/argo-workflows
fi

if [[ "${MACHINE_ARCH}" == "aarch64" ]] && [[ "${ENV_CONTAINER_DEV}" == "yes" ]];then
  # aquasecurity/trivy
  zinit ice as"command" from"gh-r" bpick"trivy_*_Linux-ARM64.tar.gz" pick"trivy"
  zinit light aquasecurity/trivy
  # anchore/syft
  zinit ice as"command" from"gh-r" bpick"*linux_arm64.tar.gz" pick"syft"
  zinit light anchore/syft
  # anchore/grype
  zinit ice as"command" from"gh-r" bpick"*linux_arm64.tar.gz" pick"grype"
  zinit light anchore/grype
  # vmware-tanzu/sonobuoy
  zinit ice as"command" from"gh-r" bpick"*_linux_arm64.tar.gz" pick"sonobuoy"
  zinit light vmware-tanzu/sonobuoy
fi

if [[ "${MACHINE_ARCH}" == "aarch64" ]] && [[ "${ENV_ARGO_DEV}" == "yes" ]];then
  # argoproj/argo-workflows
  zinit ice as"command" from"gh-r" bpick"*-linux-arm64.gz" mv"argo-linux-arm64 -> argo" pick"argo"
  zinit light argoproj/argo-workflows
fi

export LS_COLORS="$(vivid generate snazzy)"


# loaded at the end, like it is suggested by the plugin's README
zinit light zdharma-continuum/fast-syntax-highlighting

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# start pueue daemon
if [[ ! -f "${HOME}/.local/share/pueue/pueue.pid" ]]; then
        pueued -d
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
