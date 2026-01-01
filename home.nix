{ pkgs, ... }:
{

  programs.home-manager.enable = true;

  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";

    clock24 = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];

    extraConfig = ''
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initExtra = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };

  home.file.".p10k.zsh".source = ./dotfiles/.p10k.zsh;

}
