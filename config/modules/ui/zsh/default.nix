{ pkgs, lib, config, ... }:

{
  imports = [ ./zshExtras.nix ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableHistorySubstringSearch = true;
    autoSuggestions.highlightStyle = "fg=3";

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 10000;
      share = true;
      size = 50000;
    };

    historySubstring = {
      highlightFound = "fg=green";
      highlightNotFound = "fg=red";
    };

    initExtra = ''
      bindkey '^l' autosuggest-accept
      bindkey '^h' autosuggest-clear
      bindkey '^k' history-substring-search-up
      bindkey '^j' history-substring-search-down

      # Load Functions
      if [ -f ${config.home.sessionVariables.SCRIPTS}/functions ]; then
          source ${config.home.sessionVariables.SCRIPTS}/functions
      fi
    '';

    shellAliases = {
      ls = "exa -l";
      refresh = "exec $SHELL -l";
    };
  };
}