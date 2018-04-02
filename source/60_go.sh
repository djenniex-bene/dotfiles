export GOPATH=$HOME/go

if [[ -b $GOPATH ]]; then
  export $PATH=$PATH:$GOPATH/bin
fi
