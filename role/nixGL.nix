{ pkgs, lib }:

pkg:

let
  nixGL = import <nixgl> { };
  bins = "${pkg}/bin";
in pkgs.buildEnv {
  name = "nixGL-${pkg.name}";
  paths = [ pkg ] ++ (map (bin:
    lib.hiPrio (pkgs.writeShellScriptBin bin ''
      shopt -s extglob
      vars=""
      while read -r line; do
        if [[ "$line" = *"export"* ]]; then
          vars+="''${line##export } "
        fi
      done < "${nixGL.auto.nixGLDefault}/bin/nixGL"
      shopt -u extglob
      env $vars "${bins}/${bin}" "$@"
    '')) (builtins.attrNames (builtins.readDir bins)));
  meta.priority = 1;
}
