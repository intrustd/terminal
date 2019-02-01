{ pkgs, stdenv, manifest }:

let nodePkgSet = import ./js { pkgs = pkgs.buildPackages; nodejs = pkgs.buildPackages."nodejs-8_x"; };

    nodeDeps = (nodePkgSet.shell.override { bypassCache = true; }).nodeDependencies;

in stdenv.mkDerivation {
  name = "terminal-static";
  src = (pkgs.callPackage ./ttyd {}).src + /html;

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
  '';
}
