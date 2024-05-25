# create synlink to dotfiles under ./config to XDG_CONFIG_HOME
link-dotfiles:
  #!/usr/bin/env sh
  for f in ./config/*; do
    ln -sfn $(realpath $f) $XDG_CONFIG_HOME/$(basename $f)
  done

# remove broken synlinks under XDG_CONFIG_HOME that points to ./config
remove-broken-links:
  #!/usr/bin/env sh
  for f in $XDG_CONFIG_HOME/*; do
    if [ -h $f ]; then
      fl=$(readlink $f)

      if ! stat $fl &>/dev/null && [[ $fl = $PWD/config/* ]]; then
        rm $f
      fi
    fi
  done

# run link-dotfiles, than remove-broken-links
sync-dotfiles: link-dotfiles remove-broken-links

# rebuid the system then run diff between generations
system-rebuild host mode='switch':
  nixos-rebuild {{mode}} --use-remote-sudo --flake ".#{{host}}" \
  && nix store diff-closures $(\ls -d /nix/var/nix/profiles/*|tail -2)

# update and rebuild the system, then run diff between generations
system-update host mode='switch':
  #!/usr/bin/env sh
  nix flake update
  git diff --quiet flake.lock || (git add flake.lock && git commit -m "system update")
  nixos-rebuild {{mode}} --use-remote-sudo --flake ".#{{host}}" \
  && nix store diff-closures $(\ls -d /nix/var/nix/profiles/*|tail -2)

# collect garbage on nix store, system and home-manager
system-gc:
  #!/usr/bin/env sh
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
  nix profile wipe-history --profile ~/.local/state/nix/profiles/home-manager
  nix store gc
