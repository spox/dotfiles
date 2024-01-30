{ pkgs, lib }:

pkg:

let
  nixGL = import <nixgl> { };
  bins = "${pkg}/bin";
in pkgs.buildEnv {
  name = "nixGL-${pkg.name}";
  paths = [ pkg ] ++ (map (bin:
    lib.hiPrio (pkgs.writeShellScriptBin bin ''
      . "${nixGL.auto.nixGLDefault}/bin/nixGL"
      export -n LIBGL_DRIVERS_PATH
      export -n LIBVA_DRIVERS_PATH
      export -n __EGL_VENDOR_LIBRARY_FILENAMES
      export -n LD_LIBRARY_PATH
      exec -a "$0" "${bins}/${bin}" "$@"
    '')) (builtins.attrNames (builtins.readDir bins)));
  meta.priority = 1;
}
