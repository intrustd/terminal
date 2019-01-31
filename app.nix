{ pkgs, ... }:

{

  app.version = { major = 0; minor = 1; };

  app.meta = {
    slug = "terminal";
    name = "Intrustd Terminal";
    authors = [ "Travis Athougies <travis@athougies.net>" ];
    app-url = "https://terminal.intrustd.com/";
    icon = "https://terminal.intrustd.com/images/terminal.svg";
  };

  app.identifier = "terminal.intrustd.com";

  app.startHook = ''
    export PATH=/bin
    exec ${pkgs.gotty.bin}/bin/gotty ${pkgs.bash}/bin/bash
  '';

  app.healthCheckHook = ''
    ${pkgs.procps}/bin/ps -A | ${pkgs.gnugrep}/bin/grep gotty
    exit $?
  '';

}
