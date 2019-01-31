import <intrustd/nix/hydra-app-jobsets.nix> {
  description = "Intrustd Terminal App";
  src = { type = "git"; value = "git://github.com/intrustd/terminal.git"; emailresponsible = true; };
}
