{ pkgs, ... }:

let ttyd = pkgs.callPackage ./ttyd.nix {};
in {

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
    exec ${ttyd}/bin/ttyd -p 80 ${pkgs.bash}/bin/bash
  '';

  app.healthCheckHook = ''
    ${pkgs.procps}/bin/ps -A | ${pkgs.gnugrep}/bin/grep ttyd
    exit $?
  '';

  app.permissions = [
    { name = "access";
      description = "Access a terminal on this appliance"; }
  ];

  app.permsHook =
    let hook = pkgs.writeScript "terminal-perms" ''
        #!/bin/sh
        ACTION=none
        PERSONA=
        APP=

        while [ $# -ne 0 ]; do
          case "$1" in
            -L|--lookup)   ACTION=lookup ;;
            -c|--check)    ACTION=check ;;
            -D|--describe) ACTION=describe ;;
            -p|--persona)  PERSONA="$2"; shift ;;
            -a|--application) APP="$2"; shift ;;
          esac
          shift
        done

        case "$ACTION" in
          lookup)
            echo "Do not understand -L or --lookup yet" >2
            exit 2
            ;;

          check)
            echo "Do not understand -c or --check yet" >2
            exit 2
            ;;

          describe)
            echo '['

            while read PERM; do
              case "$PERM" in
                intrustd+perm://terminal.intrustd.com/access)
                  cat <<EOF
                   { "short": "Access a terminal via this appliance" }
        EOF
                  ;;

                "")
                  break
                  ;;

                *)
                  ;;
              esac
            done

            echo ']'
            ;;

          *)
            echo "Invalid command"
            exit 2
            ;;
        esac
      '';
    in "${hook}";

}
