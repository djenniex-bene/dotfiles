export GOPATH=$HOME/go

if [[ -d $GOPATH ]]; then
  export PATH=$PATH:$GOPATH/bin
fi
