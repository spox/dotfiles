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
      while read -r line; do
        if [[ "$line" = *"export"* ]]; then
          eval "$line"
        fi
      done < "${nixGL.auto.nixGLDefault}/bin/nixGL"
      shopt -u extglob
      export -n LIBGL_DRIVERS_PATH
      export -n LIBVA_DRIVERS_PATH
      export -n __EGL_VENDOR_LIBRARY_FILENAMES
      export -n LD_LIBRARY_PATH
      exec -a "$0" "${bins}/${bin}" "$@"
    '')) (builtins.attrNames (builtins.readDir bins)));
  meta.priority = 1;
}
