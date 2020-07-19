alias bashupdate='sudo apt update && sudo apt upgrade'
alias cfg='command git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ..='cd ..'

alias acfg='vim ~/.bash_aliases'
alias bcfg='vim ~/.bashrc'
alias fcfg='vim ~/.bash_functions'
alias vcfg='vim ~/.vim/vimrc'
alias load='source ~/.bashrc'

alias ls='ls --color=auto --group-directories-first --quoting-style=literal'
alias grep='grep --color=auto'
alias cat='cat -v'
alias diff='diff -y --color=auto'

alias python='python3'
alias pip='pip3'

function mount-usb {
    ps_path="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
    cmd="& Get-PSDrive | Select-Object -ExpandProperty 'Name' | Select-String -Pattern '^[a-z]$'"

    drive_letters=`${ps_path} -Command ${cmd}`
    mounted=`ls -1 -Iwsl /mnt/`

    if [[ $# -ne 1 ]]; then
        echo "Incorrect arguments!"
        echo "Usage: mount-usb <drive letter>"
        return
    fi

    drive_letters=${drive_letters,,}
    arg=${1,,}

    if [[ ${arg} =~ ^[a-z]$ ]]; then
        if [[ ${drive_letters} =~ ${arg} ]]; then
            if [[ ${mounted} =~ ${arg} ]]; then
                echo "The specified drive (${arg}) is already mounted!"
            else
                echo "Mounting drive (${arg})..."
                sudo mkdir /mnt/${arg}
                sudo mount -t drvfs ${arg^^}: /mnt/${arg}
                echo "Finished!"
            fi
        else
            echo "Could not find a mounted drive with the specified drive letter!"
        fi
    else
        echo "Enter a valid drive letter [A-Z]!"
    fi
}

function unmount-usb {
    mounted=`ls -1 -Iwsl /mnt/`

    if [[ $# -ne 1 ]]; then
        echo "Incorrect arguments!"
        echo "Usage: unmount-usb <drive letter>"
        return
    fi

    arg=${1,,}

    if [[ ${arg} =~ ^[a-z]$ ]]; then
        if [[ ${mounted} =~ ${arg} ]]; then
            echo "Unmounting drive (${arg})..."
            sudo umount /mnt/${arg}
            sudo rm -rf /mnt/${arg}
            echo "Finished!"
        else
            echo "Could not find a mounted drive with the specified drive letter!"
        fi
    else
        echo "Enter a valid drive letter [A-Z]!"
    fi
}
