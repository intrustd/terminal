{ pkgs, stdenv, manifest }:

let nodePkgSet = import ./js { pkgs = pkgs.buildPackages; nodejs = pkgs.buildPackages."nodejs-8_x"; };

    nodeDeps = (nodePkgSet.shell.override { bypassCache = true; }).nodeDependencies;

    icon = pkgs.runCommand "terminal.svg" { infile = ./terminal.svg; passAsFile = [ "infile" ];} ''
      cp $infile $out
    '';

in stdenv.mkDerivation {
  name = "terminal-static";
  src = ./js;

  nativeBuildInputs = with pkgs; [ nodeDeps nodejs-8_x ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    ln -s ${nodeDeps}/lib/node_modules ./node_modules
    ln -s ${nodeDeps}/lib/package-lock.json ./package-lock.json
    npm run build
  '';

  installPhase = ''
     cp -R ./dist $out
     cp ${manifest} $out/manifest.json

     mkdir -p $out/images/
     cp ${icon} $out/images/terminal.svg
  '';
}
