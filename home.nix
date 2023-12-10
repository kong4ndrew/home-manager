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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "SourceCodePro" ]; })

    sf-mono-liga-bin

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
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

#===-===-===~/.config/nvim/lua/andrewkong/...===-===-===-#

           #---------- init.lua ----------#
           #                              #
    ".config/nvim/lua/andrewkong/init.lua".text = ''
        require('andrewkong.remaps')
        require('andrewkong.set')
    '';
           #                              #
           #------------------------------#

           #--------- remaps.lua ---------#
           #                              #
    ".config/nvim/lua/andrewkong/remaps.lua".text = ''
        vim.g.mapleader = ' '
        vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

        vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")                  -- When in visual mode, 'J' will move the line down
        vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")                  -- When in visual mode, 'K' will move the line up

        vim.keymap.set('n', 'J'    , 'mzJ`z')                         -- Joining lines will keep cursor where it originally was. (mark 'z' + 'J' + return back to mark 'z')
        vim.keymap.set('n', '<C-d>', '<C-d>M')                        -- <C-d> will keep the cursor in the middle of the screen (<C-d> + 'M')
        vim.keymap.set('n', '<C-u>', '<C-u>M')                        -- <C-u> will keep the cursor in the middle of the screen (<C-u> + 'M')
        vim.keymap.set('n', '<C-m>', '<C-e>M')                        -- <C-m> will scroll down one row and keep the cursor in the middle of the screen ('<C-e>' + 'M')
        vim.keymap.set('n', '<C-y>', '<C-y>M')                        -- <C-y> will scroll up one row and keep the cursor in the middle of the screen ('<C-y>' + 'M')
        vim.keymap.set('n', 'n'    , 'nzzzv')                         -- When searching, keeps cursor in the middle of the screen
        vim.keymap.set('n', 'N'    , 'Nzzzv')                         -- When searching, keeps cursor in the middle of the screen

        vim.keymap.set('x', '<leader>p', '\"_dP')                     -- When pasting over something, don't replace vim clipboard with whatever was pasted over

        vim.keymap.set('n', '<leader>y', '\"+y')                      -- <leader>(yanks) will copy to system clipboard
        vim.keymap.set('v', '<leader>y', '\"+y')
        vim.keymap.set('n', '<leader>Y', '\"+Y')

        vim.keymap.set('n', '<leader>d', '\"_d')                      -- <leader>(deletes) will not copy to vim clipboard
        vim.keymap.set('v', '<leader>d', '\"_d')
        vim.keymap.set('n', '<leader>D', '\"_D')                      
        vim.keymap.set('n', '<leader>c', '\"_c')                      -- <leader>(changes) will not copy to vim clipboard
        vim.keymap.set('n', '<leader>C', '\"_C')                      

        vim.keymap.set('n', 'Q', '<nop>')

        vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')              -- Something to do with "quick fix navigation"?...
        vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
        vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
        vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

        vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Incrementally changes every instance of the word your cursor is on.
        vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })              -- Sets execute permission on the current file

    '';
           #                              #
           #------------------------------#

           #---------- set.lua -----------#
           #                              #
    ".config/nvim/lua/andrewkong/set.lua".text = ''
        vim.opt.nu             = true
        vim.opt.relativenumber = true

        vim.opt.tabstop        = 4
        vim.opt.shiftwidth     = 4
        vim.opt.smarttab       = false                                -- To tab 4 spaces but delete 1, set smarttab = false and softtabstop = 0 
		vim.opt.expandtab      = true
        
        vim.opt.smartindent    = false                                -- Enabling this causes causes the closing brace to start one level shifted right for some reason
        
        vim.opt.wrap           = false

        vim.opt.swapfile       = true
        vim.opt.backup         = false                                -- By default backup = false and writebackup = true...
        vim.opt.undodir        = os.getenv('HOME') .. "/.vim/undodir" -- In Lua, .. is the string concatenation operator
        vim.opt.undofile       = true

        vim.opt.hlsearch       = true                                -- Prevent search highlights from persisting 
        vim.opt.incsearch      = true                                 -- Use incremental search with regex to search complex entries!

        vim.opt.termguicolors  = true

        vim.opt.scrolloff      = 0                                    -- When scrolling with cursor, at least 'x' number of rows will be left between cursor and screen
        vim.opt.signcolumn     = "yes"                                -- A dedicated column for debugging signs etc.
        vim.opt.isfname:append("@-@")                                 -- This allows vim to operate on files that have @ in their file name.
        
        vim.opt.updatetime     = 50

        vim.opt.foldmethod     = 'expr'                               -- Vim will scan each line for the provided definition of 'foldexpr'
        vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'         -- Treesitter's foldexpr definitions
        vim.opt.foldenable     = false                                -- Folds are disabled at startup

        vim.g.mapleader        = ' '
    '';
           #                              #
           #------------------------------#

#===-===-===-===-===-===-===-===-===-===-===-===-===-===-#

#===-===-===~/.config/nvim/after/plugin/...===-===-===-===#

           #------- telescope.lua --------#
           #                              #
    ".config/nvim/after/plugin/telescope.lua".text = ''
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>'     , builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input('Grep -| ') })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    '';
           #                              #
           #------------------------------#

           #-------- lualine.lua ---------#
           #                              #                                         
    ".config/nvim/after/plugin/lualine.lua".text = ''
        require('lualine').setup {
            options = {
                theme = 'dayfox',
                --theme = 'tokyonight',
                --theme = 'solarized_light',
            },
        } 
    '';
           #                              #
           #------------------------------#

           #-------- colors.lua ----------#
           #                              #
    ".config/nvim/after/plugin/colors.lua".text = ''

        -- In the future, add a way to reload lualine and kitty as well?
        function colormoi(color)
            color = color or 'dayfox'
            vim.cmd.colorscheme(color)

            vim.api.nvim_set_hl(0, "Normal", { bg = none })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = none })

        end

        -- Nightfox configuration
        require('nightfox').setup({
            options = {
                styles = {  
                    comments  = "bold,italic",
                    keywords  = "bold",
                    types     = "bold",
                    functions = "italic"
                },
            },
        })

        colormoi()
    '';
           #                              #
           #------------------------------#

           #------- treesitter.lua -------#
           #                              #
    ".config/nvim/after/plugin/treesitter.lua".text = ''
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        })
    '';
           #                              #
           #------------------------------#

           #-------- harpoon.lua ---------#
           #                              #
    ".config/nvim/after/plugin/harpoon.lua".text = ''
        local harpoon = require('harpoon')

        harpoon:setup()

        vim.keymap.set('n', '<leader>a', function() harpoon:list():append() end)
        vim.keymap.set('n', '<C-e>'    , function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set('n', '<C-h>'    , function() harpoon:list():select(1) end)
        vim.keymap.set('n', '<C-t>'    , function() harpoon:list():select(2) end)
        vim.keymap.set('n', '<C-n>'    , function() harpoon:list():select(3) end)
        vim.keymap.set('n', '<C-s>'    , function() harpoon:list():select(4) end)
    '';
           #                              #
           #------------------------------#

           #-------- undotree.lua --------#
           #                              #
    ".config/nvim/after/plugin/undotree.lua".text = ''
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    '';
           #                              #
           #------------------------------#

           #-------- fugitive.lua --------#
           #                              #
    ".config/nvim/after/plugin/fugitive.lua".text = ''
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    '';
           #                              #
           #------------------------------#

           #------- indentline.lua -------#
           #                              #
    ".config/nvim/after/plugin/indentline.lua".text = ''
        require('ibl').setup({
            indent = { char = '┊'},
            scope = { enabled = false },
        })
    '';
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
    enable       = true;
    dotDir       = ".config/zsh";
    shellAliases = {
        hm = "home-manager switch --flake ~/.config/home-manager";
        config = "cd ~/.config/home-manager && nvim home.nix";
    };
    prezto = {
        enable = true;
        prompt.theme = "powerline";
    };
    loginExtra = " ponysay -b ascii -- '⭐ The Lord is FOR you and not AGAINST you! ⭐' ";
};

#===============================================================================================================================================#

#KITTY==========================================================================================================================================#

programs.kitty = {
    enable = true;
    theme  = "Alabaster";
#    theme  = "Tokyo Night";
#    theme = "CLRS";
    font = {
        size = 15;
        name = "Liga SFMono Nerd Font Medium"; # Check FontBook for the name because it must be verbatim.
    };
    shellIntegration = {
        mode = "enabled";
        enableZshIntegration = true;
    };
    settings = {
        bold_font                  = "Liga SFMono Nerd Font Bold";
        italic_font                = "Liga SFMono Nerd Font SemiBold";     # Basically doing this to hack a semibold option in neovim.
        bold_italic_font           = "Liga SFMono Nerd Font Light Italic"; #
        cursor_blink_interval      = 0;
        background_blur            = 64;
        background_opacity         = "0.75";
#        background                 = "#fdf6e3";
#        dynamic_background_opacity = true;
    };
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
          plugin = harpoon;
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
          ]);
          type   = "lua";
        }

    ]; 
    extraPackages = with pkgs; [
      ripgrep
      fd
      nodePackages.npm
      nodePackages.neovim
    ];
  };

#===============================================================================================================================================#

#GIT============================================================================================================================================#

programs.git = {
    userName  = "kong4ndrew";
    userEmail = "kong4ndrew@gmail.com";
};

#===============================================================================================================================================#

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
