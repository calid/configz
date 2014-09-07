
if [ -d $HOME/.profile.d ]
then
    for f in $HOME/.profile.d/*.sh
    do
        . $f
    done
fi

PATH=$HOME/bin:$PATH

# vim: ft=sh
