# Add Go binaries to PATH if Go is installed
if command -v go >/dev/null 2>&1; then
  export PATH="$PATH:$(go env GOROOT)/bin:$(go env GOPATH)/bin"
fi

# Add asdf shims to PATH if asdf exists
if command -v asdf >/dev/null 2>&1; then
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi
