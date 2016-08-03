#

# El noclobber sirve para evitar destruir archivos preexistentes en el sistema mediante el uso de la línea de comandos. Si se quiere cambiar esta opción, poner set +o noclobber
# Recordar que a esto se le puede sacar la vuelta en bash mediante el uso de un símbolo de pipa | después del símbolo de redireccionamiento > 
set -o noclobber

# MacPorts Installer addition on 2009-01-12_at_23:31:53: adding an appropriate PATH variable for use with MacPorts.
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
# Finished adapting your PATH environment variable for use with MacPorts.
export PATH=$PATH:/usr/share/cups/

# MacPorts Installer addition on 2009-01-12_at_23:31:53: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=$MANPATH:/opt/local/share/man
# Finished adapting your MANPATH environment variable for use with MacPorts.


alias Emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias l2r="latex2rtf"
alias thpr="/Applications/Thunderbird.app/Contents/MacOS/thunderbird-bin -ProfileManager"
alias cp="cp -i"
alias rm="rm -i"
alias srm="srm -i"
alias ls="ls -shFG"
alias ll="ls -l"
alias lm="ls | more"
alias la="ls -a | more"
alias libre="open -a /Applications/LibreOffice.app"
alias acuam="open -a /Applications/Aquamacs.app"
alias textedit="open -a /Applications/TextEdit.app"
alias gristory="history | grep"
alias salvacad="rsync -CauE /Users/g/Documents/_Docs/Academia /Volumes/Backup/Academia/"
alias salvancad="rsync -CauE /Users/g/Documents/_Docs/Academia/publicacionesYponencias/z_Colef/_muro_ambiente/  /Volumes/dav/Backup/Academia/"
alias salvaplan="set -e ; rsync -CauE /Users/g/Documents/_Docs/Academia/Colef/Libros/confCGF/dmaesCGF /Volumes/KINGSTON/_Plan/ ; say 'your backup is ready dear Gigi'"
alias atexto="textutil -convert txt"
alias artf="textutil -convert rtf"
alias artff="textutil -convert rtf -font TimesNewRoman -fontsize 12 -encoding UTF-8"
alias catt='textutil -convert txt  $1 -stdout | cat | more'
alias cath='cat | textutil -convert txt  -stdin -stdout -format html | more'
alias datosfoto="identify -verbose"
alias cabeza=' | head 17'
alias atiff='gs -dNOPAUSE -q -sDEVICE=tiff32nc -dBATCH -dTextAlphaBits=4 -sOutputFile=$1'

# Sometimes I want to put the path to my present working directory into the clipboard in order to use it elsewhere (in a script ). I've added the following alias to my .profile 
alias gpwd="pwd | tr -d '\n' | pbcopy "
# del libro de Sobell y Seebach:
alias ch="chmod 755 "
alias profile="emacs ~/.profile"

test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Este par de funciones (que no recuerdo dónde las encontré, aunque creo que fue en MacOsXHints.com -- creo que así se llama) está muy bien por dos motivos: 1) facilita el encriptado de archivos (para encriptar directorios, primero hay que convertirlos en zip o gz); 2) permite el estudio de los escripts. Se trata de un script muy sencillo en el que podría inspirarme para escribir mis propios escripts de funciones útiles y que uso con frecuencia.
function encrypt {
  if [ "$1" = "" ]; then
    echo "Usage: encrypt filename"
  elif [ -d "$1" ]; then
    echo ""$1" is a directory"
  elif [ -L "$1" ]; then
    echo ""$1" is a symbolic link"
  elif ! [ -r "$1" ]; then
    echo ""$1" is not readable"
  else
    /usr/bin/openssl aes-256-cbc -salt -in "$1" -out "$1".aes
      if [ $? -eq 0 ] ; then
        echo "encrypted file: "$1".aes"
      fi
    srm "$1"
  fi
}

function decrypt {
  if [ "$1" = "" ] || [ "${1##*.}" != aes ]; then
    echo "Usage: decrypt filename.aes"
  else
    /usr/bin/openssl aes-256-cbc -d -salt -in "$1" -out "${1%.aes}" 2>/dev/null
      if [ $? -eq 0 ] ; then
        echo "decrypted file: ${1%.aes}"
      else
        /bin/rm "${1%.aes}"
        echo -e "bad decrypt, possible incorrect password \n(${1%.aes} deleted)"
      fi
  fi
}

# Alias que eoncontré en la red (véanse créditos en applescript ubicado en qrchiv de scripts de mi librería personal) 

alias newtab='osascript ~/bin/newtab.scpt `pwd`'

# Alias mío para determinar cuándo fue la última vez que se corrieron los periodic miantenance scripts --no olvidar que el comando para correr las rutinas de mantenimiento es 
# sudo periodic daily weekly monthly --


alias lastmaint='ls -l /var/log/*.out | cut -d\K -f2 | cut -d\/ -f1,4 | /usr/local/bin/growlnotify -s -t "Últimas rondas de mantenimiento"'


function finscript {
 #
 # Runs script, and prints a notification with growl when it finishes
 #

 $*
 growlnotify -m "Script '$*' completed" -s "Background script notification" &
}



# Agregamos ahora los PATH adecuados para mi versión más reciente de ImageMagick

export MAGICK_HOME="/usr/local/ImageMagick-6.5.9"
export PATH=$PATH:~/bin:/usr/local/clamXav/bin:/usr/local/ImageMagick-6.5.9/bin
export DYLD_LIBRARY_PATH=/usr/local/ImageMagick-6.5.9/lib:$DYLD_LIBRARY_PATH
PS1='\W \u \$ '
export CDPATH=.:~:/Users/g/Documents/_Docs/_trabajo/:/Users/g/Documents/_Docs/Academia/publicacionesYponencias/
#export MAILCHECK=100000000000

# # function colorcheck {
# #  if [ "$1" = "" ]; then
#      echo "Usage: colorcheck filename"
#   elif [ -d "$1" ]; then
#     echo ""$1" is a directory"
#   elif [ -L "$1" ]; then
#     echo ""$1" is a symbolic link"
#   elif ! [ -r "$1" ]; then
#     echo ""$1" is not readable"
#   else
# convert "$1" miff:- | convert - -scale 1x1! -format %[fx:u.r==u.g&&u.r==u.b?1:0] info:
#   fi
# }

# Tip on bash history found on http://www.mactech.com/articles/mactech/Vol.24/24.10/2410MacintheShell/index.html

export HISTSIZE=12000
export HISTFILESIZE=12000
export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%b %d %H:%M: '
shopt -s histappend		# adjunta historia de toda shell a la historia
set cmdhist			# pone en una sola línea lo de varias


if [ -f /sw/etc/bash-completion-1.1/bash_completion ]; then
   . /sw/etc/bash-completion-1.1/bash_completion
fi

# Get my IP address from the web and from the the terminal
alias myipweb='curl -s http://checkip.dyndns.org/ | grep " IP Address:" | cut -d\  -f4- | cut -d\< -f1 | /usr/local/bin/growlnotify -s'

alias myipterm='ifconfig | grep "inet " | grep -v "127.0.0.1" | cut -d\  -f2 | /usr/local/bin/growlnotify -s'

# El siguiente script se inspira en varios artículos de Mac OS X Hints
function recuerda {
  if [ $# != 2 ]; then
      echo "Uso: recuerda 'mensaje (si hay espacios, entre comillas)' tiempo (en segs)"
  else
      sleep $2 && growlnotify -s -t "RECUERDA" -m "$1" -a PseudoAnacron.app &
  fi
}

# Este alias sirve para copiar como texto lo que está en la memoria a un archivo en el Desktop llamado clipping.txt

alias clipping='pbpaste -Prefer txt LANG=en_US.UTF-8 > ~/Desktop/clipping.txt'

alias flash='open /private/var/folders/'
alias tamanofotos='sips -g pixelWidth -g pixelHeight * > ./photosize'