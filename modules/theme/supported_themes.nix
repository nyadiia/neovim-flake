{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with builtins;
let
  themeSubmodule.options = {
    setup = mkOption {
      description = "Lua code to initialize theme";
      type = types.str;
    };
    styles = mkOption {
      description = "The available styles for the theme";
      type = with types; nullOr (listOf str);
      default = null;
    };
    defaultStyle = mkOption {
      description = "The default style for the theme";
      type = types.str;
    };
  };

  cfg = config.vim.theme;
  style = cfg.style;
in
{
  options.vim.theme = {
    supportedThemes = mkOption {
      description = "Supported themes";
      type = with types; attrsOf (submodule themeSubmodule);
    };
  };

  config.vim.theme.supportedThemes = {
    oxocarbon = {
      setup = ''
        -- oxocarbon theme
        vim.opt.background = "${cfg.style}"
        vim.cmd.colorscheme "oxocarbon"
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      '';
      styles = [
        "dark"
        "light"
      ];
      defaultStyle = "dark";
    };
    onedark = {
      setup = ''
        -- OneDark theme
        require('onedark').setup {
          style = "${cfg.style}"
        }
        require('onedark').load()
      '';
      styles = [
        "dark"
        "darker"
        "cool"
        "deep"
        "warm"
        "warmer"
      ];
      defaultStyle = "dark";
    };

    tokyonight = {
      setup = ''
        -- need to set style before colorscheme to apply
        require("tokyonight").setup({
          style = "${cfg.style}",
        })
        vim.cmd[[colorscheme tokyonight]]
      '';
      styles = [
        "day"
        "night"
        "storm"
        "moon"
      ];
      defaultStyle = "night";
    };

    catppuccin = {
      setup = ''
        -- Catppuccin theme
        require('catppuccin').setup {
          flavour = "${cfg.style}"
        }
        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
      '';
      styles = [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      defaultStyle = "mocha";
    };

    dracula-nvim = {
      setup = ''
        require('dracula').setup({});
        require('dracula').load();
      '';
    };

    dracula = {
      setup = ''
        vim.cmd[[colorscheme dracula]]
      '';
    };

    gruvbox = {
      setup = ''
        -- gruvbox theme
        vim.o.background = "${cfg.style}"
        vim.cmd.colorscheme "gruvbox"
      '';
      styles = [
        "dark"
        "light"
      ];
      defaultStyle = "dark";
    };

    gruvbox-material = {
      setup = ''
        vim.g.gruvbox_material_enable_italic = true
        vim.o.background = "${cfg.style}"
        vim.cmd.colorscheme "gruvbox-material"
      '';
      styles = [
        "dark"
        "light"
      ];
      defaultStyle = "dark";
    };
  };
}
