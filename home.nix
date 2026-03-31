# ~/dotfiles/home.nix
{ config, pkgs, ... }:

{
  home.username = "yon";
  home.homeDirectory = "/home/yon";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    htop
    python3
    gnumake
    gcc
    eza
    bat
    dust
    bottom
    gnupg
    pinentry-curses
  ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    defaultCacheTtl = 3600;
  };

  home.sessionVariables = {
    PATH = "$HOME/.bun/bin:$PATH";
    GOOGLE_CLOUD_PROJECT = "tryandgoaroundme";
  };

  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 10000;
    shellAliases = {
      # nixos
      nix-switch = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
      nix-update = "pushd ~/dotfiles && nix flake update && nix-switch && popd";
      nix-clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      nix-search = "nix search nixpkgs";

      # vim
      viconf = "nvim ~/dotfiles/configuration.nix";
      vihome = "nvim ~/dotfiles/home.nix";
      viflake = "nvim ~/dotfiles/flake.nix";

      # utils
      ls = "eza --icons --group-directories-first";
      ll = "eza -lha --icons --group-directories-first";
      lt = "eza --tree --icons"; # tree view
      cat = "bat";
      top = "btm"; # bottom (modern htop)
      du = "dust"; # dust (modern du)
      cd = "z";    # zoxide (smart cd)
      cl = "clear";

      # git
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";

      # gnupg
      gpsk = "gpg --list-secret-keys --keyid-format LONG";
      gpgk = "gpg --full-generate-key";

      # windows
      explorer = "explorer.exe .";
      win-dl = "cd /mnt/c/Users/$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')/Downloads";
      win-dt = "cd /mnt/c/Users/$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')/Desktop";
      dos2unix-all = "find . -type f -exec dos2unix {} +";
    };

    initExtra = ''
      export EDITOR="nano"
      export GPG_TTY=$(tty)
      mkd() {
        mkdir -p "$1" && cd "$1"
      }
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Yon";
        email = "154914363+tachy0nnn@users.noreply.github.com";
      };

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      core.autocrlf = "input";
    };
    signing = {
      format = "openpgp";
      key = "517B5C977B005C15";
      signByDefault = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      syntax-theme = "GitHub";
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bun.enable = true;
  programs.codex.enable = true;
}
