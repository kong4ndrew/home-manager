{ config, pkgs, inputs, ... }:

{
#SFMONO-NERD-FONT-LIGATURIZED===================================================================================================================#

# Any nixpkg overlays must come BEFORE any home.package.pkgs declarations!
# Maybe at some point make a separate ./nixpkgs/overlays.nix module to modularize 
# overlays in your flake.nix?

# For more information check out nixos.wiki on overlays: https://nixos.wiki/wiki/Overlays

nixpkgs.overlays = [
    (final: prev: {
        sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
            pname = "sf-mono-liga-bin";
            version = "dev";
            src = inputs.sf-mono-liga-src;
            dontConfigure = true;
            installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp -R $src/*.otf $out/share/fonts/opentype/
            '';
        };
    })
];

#===============================================================================================================================================#

#LOCAL USER INFORMATION=========================================================================================================================#

# Home Manager needs a bit of information about you and the paths it should
# manage.

home = {
    username = "andrewkong";
    homeDirectory = "/Users/andrewkong";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11";
};

#===============================================================================================================================================#


#MACOS GLOBAL AND LOCAL USER DEFAULTS===========================================================================================================#

# Use this if you want to set system and user level defaults?
targets.darwin = {
    defaults = { };
    currentHostDefaults = { };
};

#===============================================================================================================================================#


#HOME MANAGER PACKAGES==========================================================================================================================#

# The home.packages option allows you to install Nix packages into your
# environment.
home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    ponysay

    bat

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "SourceCodePro" ]; })

    sf-mono-liga-bin

    texliveFull
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

];

#HOME FILES=====================================================================================================================================#

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.

    # # To source something like this you have to GIT ADD it! Nix takes into 
    # # consideration the git index...I wasted so much time figuring that one out!!! 
    # # Also, the file must be in the same directory as home.nix and flake.nix. Using a
    # # higher-level path gives you an error and trying to reference the path is
    # # considered 'impure'.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

#===-===-===~/.config/nvim/lua/andrewkong/...-===-===-===-#

           #---------- init.lua ----------#
           #                              #
    ".config/nvim/lua/andrewkong/init.lua".source = ./nvim/lua/andrewkong/init.lua;
           #                              #
           #------------------------------#

           #--------- remaps.lua ---------#
           #                              #
    ".config/nvim/lua/andrewkong/remaps.lua".source = ./nvim/lua/andrewkong/remaps.lua;
           #                              #
           #------------------------------#

           #---------- set.lua -----------#
           #                              #
    ".config/nvim/lua/andrewkong/set.lua".source = ./nvim/lua/andrewkong/set.lua;
           #                              #
           #------------------------------#

#-===-===-===-===-===-===-===-===-===-===-===-===-===-===-#

#===-===-===~/.config/nvim/after/plugin/...===-===-===-===#

           #----------- lsp.lua ----------#
           #                              #
    ".config/nvim/after/plugin/lsp.lua".source = ./nvim/after/plugin/lsp.lua;
           #                              #
           #------------------------------#

           #------- telescope.lua --------#
           #                              #
    ".config/nvim/after/plugin/telescope.lua".source = ./nvim/after/plugin/telescope.lua;
           #                              #
           #------------------------------#

           #-------- lualine.lua ---------#
           #                              #                                         
    ".config/nvim/after/plugin/lualine.lua".source = ./nvim/after/plugin/lualine.lua;
           #                              #
           #------------------------------#

           #-------- colors.lua ----------#
           #                              #
    ".config/nvim/after/plugin/colors.lua".source = ./nvim/after/plugin/colors.lua;
           #                              #
           #------------------------------#

           #------- treesitter.lua -------#
           #                              #
    ".config/nvim/after/plugin/treesitter.lua".source = ./nvim/after/plugin/treesitter.lua;
           #                              #
           #------------------------------#

           #-------- harpoon.lua ---------#
           #                              #
    ".config/nvim/after/plugin/harpoon.lua".source = ./nvim/after/plugin/harpoon.lua;
           #                              #
           #------------------------------#

           #-------- undotree.lua --------#
           #                              #
    ".config/nvim/after/plugin/undotree.lua".source = ./nvim/after/plugin/undotree.lua;
           #                              #
           #------------------------------#

           #-------- fugitive.lua --------#
           #                              #
    ".config/nvim/after/plugin/fugitive.lua".source = ./nvim/after/plugin/fugitive.lua;
           #                              #
           #------------------------------#

           #------- indentline.lua -------#
           #                              #
    ".config/nvim/after/plugin/indentline.lua".source = ./nvim/after/plugin/indentline.lua;
           #                              #
           #------------------------------#

           #--------- tabby.lua ----------#
           #                              #
    ".config/nvim/after/plugin/tabby.lua".source = ./nvim/after/plugin/tabby.lua;
           #                              #
           #------------------------------#

           #--------- vimtex.lua ----------#
           #                              #
    ".config/nvim/after/plugin/vimtex.lua".source = ./nvim/after/plugin/vimtex.lua;
           #                              #
           #------------------------------#

#===-===-===-===-===-===-===-===-===-===-===-===-===-===-#


};

#HOME SESSION VARIABLES=========================================================================================================================#

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. If you don't want to manage your shell through Home
# Manager then you have to manually source 'hm-session-vars.sh' located at
# either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/andrewkong/etc/profile.d/hm-session-vars.sh
#
home.sessionVariables = {
    EDITOR   = "nvim";
    TERMINAL = "kitty";
};

#===============================================================================================================================================#

#ZSH============================================================================================================================================#

programs.zsh = {
    enable           = true;
    dotDir           = ".config/zsh";
    enableCompletion = true;
    initExtra        = "
        # Sourcing p10k.zsh for powerlevel10k
        [[ ! -f ${./zsh/p10k.zsh} ]] || source ${./zsh/p10k.zsh} 

        # Remove delay in registering ESC
        KEYTIMEOUT=1
    ";

    prezto = {
        enable        = true;
        color         = true;
        editor.keymap = "vi";
        prompt.theme  = "powerlevel10k";
    };

    shellAliases = {
        hm     = "home-manager switch --flake ~/.config/home-manager";
        config = "cd ~/.config/home-manager && nvim home.nix";
        so     = "cd ~/Documents/'Soteric 23-24' && nvim README.md";
        alg1   = "cd ~/Desktop/'Soteric 22-23' && zathura Alg1.pdf";
        Alg1   = "cd ~/Desktop/'Soteric 22-23' && zathura Algebra1Answers.pdf";
        alg2   = "cd ~/Desktop/'Soteric 22-23' && zathura Alg2.pdf";
        Alg2   = "cd ~/Desktop/'Soteric 22-23' && zathura Algebra2Answers.pdf";
        calc   = "cd ~/Desktop/'Soteric 22-23' && zathura Cal.pdf";
        Calc   = "cd ~/Desktop/'Soteric 22-23' && zathura Cal10eAnswers.pdf";
        geo    = "cd ~/Desktop/'Soteric 22-23' && zathura Geo.pdf";
        Geo    = "cd ~/Desktop/'Soteric 22-23' && zathura GeometryAnswers.pdf";
        phy    = "cd ~/Desktop/'Soteric 22-23' && zathura Alg1.pdf";
        Phy    = "cd ~/Desktop/'Soteric 22-23' && zathura PhysicsAnswers.pdf";
        lat    = "cd ~/Documents/'Soteric 23-24/Latex Lesson Plans' && nvim template.tex";
        Lat    = "cd ~/Documents/'Soteric 23-24/Latex Lesson Plans' && zathura template.pdf";
    };

    loginExtra = "ponysay -b ascii -- '⭐ The Lord is FOR you and not AGAINST you! ⭐'";

    dirHashes = {
        soteric = "$HOME/Documents/Soteric\ 23-24";
        youth   = "$HOME/Documents/Youth";
        tb      = "$HOME/Desktop/Soteric\ 22-23";
        latx    = "$HOME/Documents/Soteric\ 23-24/Latex\ Lesson\ Plans";
    };
};


#===============================================================================================================================================#

#KITTY==========================================================================================================================================#

programs.kitty = {
#    theme  = "Tokyo Night";
#    theme = "Alabaster Dark";
#    theme = "Nightfox";
#    theme = "CLRS";
    theme  = "Alabaster";
    enable = true;
    font = {
        size = 15;
        name = "Liga SFMono Nerd Font"; # Check FontBook for the name because it must be verbatim
    };
    shellIntegration = {
        mode = "enabled";
        enableZshIntegration = true;
    };
    settings = {
        bold_font             = "Liga SFMono Nerd Font Bold";
        italic_font           = "Liga SFMono Nerd Font SemiBold";     # Basically doing this to hack a semibold weight option into neovim :(
        bold_italic_font      = "Liga SFMono Nerd Font Light Italic"; # Same thing as above except with a light weight
        cursor_blink_interval = 0;
        background_blur       = 64;
        background_opacity    = "1.0";
        background_tint       = 1;
        background            = "#f8f4f0";
#        background            = "#15202B";
    };
};

#===============================================================================================================================================#

#ZATHURA==========================================================================================================================================#

programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
        default-bg = "#969696";
    };

    # Check man zathurarc for the config options
    extraConfig = ''
        set window-height         2000
        set window-width          1000
        set database              "sqlite"       # Otherwise causes warning to set database to sqlite everytime you open zathura
        set statusbar-v-padding   5
        set window-icon-document  true           # Setting icons don't appear to work
        set window-title-basename true
        set window-title-page     true
    '';
};

#===============================================================================================================================================#

#NEOVIM=========================================================================================================================================#

programs.neovim = {
    enable         = true;
    defaultEditor  = true;
    extraLuaConfig = ''
      require('andrewkong')
    '';
    plugins = with pkgs.vimPlugins; [

        {
          plugin = nightfox-nvim;
          type   = "lua";
        }
        {
          plugin = solarized-nvim;
          type   = "lua";
        }
        {
          plugin = tokyonight-nvim;
          type   = "lua";
        }
        {
          plugin = catppuccin-nvim;
          type   = "lua";
        }
        {
          plugin = lualine-nvim;
          type   = "lua";
        }
        {
          plugin = telescope-nvim;
          type   = "lua";
        }
        {
          plugin = harpoon2;
          type   = "lua";
        }
        {
          plugin = undotree;
          type   = "lua";
        }
        {
          plugin = vim-fugitive;
          type   = "lua";
        }
        {
          plugin = indent-blankline-nvim;
          type   = "lua";
        }
        {
          plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
            c
            lua
            vim
            vimdoc
            query
            nix
            swift
            bash
            html
            http
            json
            sql
            markdown
            markdown_inline
            xml
            yaml
          ]);
          type   = "lua";
        }
        {
          plugin = lsp-zero-nvim;
          type   = "lua";
        }
        {
          plugin = nvim-lspconfig;
          type   = "lua";
        }
        {
          plugin = nvim-cmp;
          type   = "lua";
        }
        {
          plugin = cmp-nvim-lsp;
          type   = "lua";
        }
        {
          plugin = luasnip;
          type   = "lua";
        }
        {
          plugin = tabby-nvim;
          type   = "lua";
        }
        {
          plugin = nvim-web-devicons;
          type   = "lua";
        }
        {
          plugin = vimtex;
          type   = "lua";
        }


    ]; 
    extraPackages = with pkgs; [
      ripgrep                 # telescope dependency
      fd                      # telescope dependency
      sourcekit-lsp           # Swift LSP
      lua-language-server     # Lua LSP
      nixd                    # Nix LSP
      nodePackages.bash-language-server # Bash LSP
      nodePackages.npm         
      nodePackages.neovim
    ];
  };

#===============================================================================================================================================#

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
