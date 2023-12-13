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

        vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")                  -- When in visual mode, 'J' will move the selected chunk down
        vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")                  -- When in visual mode, 'K' will move the selected chunk up

        vim.keymap.set('n', 'J'    , 'mzJ`z')                         -- Joining lines will keep cursor where it originally was. (mark 'z' + 'J' + return back to mark 'z')
        vim.keymap.set('n', '<C-d>', '<C-d>M')                        -- <C-d> will keep the cursor in the middle of the screen (<C-d> + 'M')
        vim.keymap.set('n', '<C-u>', '<C-u>M')                        -- <C-u> will keep the cursor in the middle of the screen (<C-u> + 'M')
        vim.keymap.set('n', '<C-f>', '<C-f>M')                        -- <C-f> will keep the cursor in the middle of the screen (<C-f> + 'M')
        vim.keymap.set('n', '<C-b>', '<C-b>M')                        -- <C-b> will keep the cursor in the middle of the screen (<C-b> + 'M')
        vim.keymap.set('n', '<C-m>', '<C-e>M')                        -- <C-m> will also keep the cursor in the middle of the screen ('<C-e>' + 'M')
        vim.keymap.set('n', '<C-y>', '<C-y>M')                        -- <C-y> will also keep the cursor in the middle of the screen ('<C-y>' + 'M')
        vim.keymap.set('n', 'n'    , 'nzzzv')                         -- When searching, keeps cursor in the middle of the screen
        vim.keymap.set('n', 'N'    , 'Nzzzv')                         -- When searching, keeps cursor in the middle of the screen

        vim.keymap.set('x', '<leader>p', '\"_dP')                     -- When pasting over something, don't replace vim clipboard with whatever was just replaced

        vim.keymap.set('n', '<leader>y', '\"+y')                      -- <leader>(yanks) will copy to system clipboard
        vim.keymap.set('v', '<leader>y', '\"+y')
        vim.keymap.set('n', '<leader>Y', '\"+Y')

        vim.keymap.set('n', '<leader>d', '\"_d')                      -- <leader>(deletes) will not copy to vim clipboard
        vim.keymap.set('v', '<leader>d', '\"_d')
        vim.keymap.set('n', '<leader>D', '\"_D')                      
        vim.keymap.set('n', '<leader>c', '\"_c')                      -- <leader>(changes) will not copy to vim clipboard
        vim.keymap.set('n', '<leader>C', '\"_C')                      

        vim.keymap.set('n', 'Q', '<nop>')

        vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')              -- Quick fix naviation-related
        vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
        vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
        vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

        vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Incrementally changes every instance of the word your cursor is on
        vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })              -- Sets execute permission on the current file

        vim.keymap.set('n', '`.'   , '`.zz')                             -- Jumping to last change will position the cursor in the middle of the screen
        vim.keymap.set('n', "'."   , "'.zz")
        vim.keymap.set('n', '<C-o>', '<C-o>zz')                          -- Jumping to previous/next jumps will position the cursor in the middle of the screen
        vim.keymap.set('n', '<C-i>', '<C-i>zz')
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

        vim.opt.hlsearch       = true                                 -- Prevent search highlights from persisting 
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
                    functions = "italic",
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
        vim.keymap.set('n', '<C-n>'    , function() harpoon:list():select(2) end)
        vim.keymap.set('n', '<C-l>'    , function() harpoon:list():select(3) end)
        vim.keymap.set('n', '<C-.>'    , function() harpoon:list():select(4) end)
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

           #----------- lsp.lua ----------#
           #                              #
    ".config/nvim/after/plugin/lsp.lua".text = ''
        local lsp_zero = require('lsp-zero')
        
        -- Setup keybindings only when a language server is attached
        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set('n', 'gd'         , function() vim.lsp.buf.definition() end      , opts)
            vim.keymap.set('n', 'K'          , function() vim.lsp.buf.hover() end           , opts)
            vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set('n', '<leader>vd' , function() vim.diagnostic.open_float() end   , opts)
            vim.keymap.set('n', '[d'         , function() vim.diagnostic.goto_next() end    , opts)
            vim.keymap.set('n', ']d'         , function() vim.diagnostic.goto_prev() end    , opts)
            vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end     , opts)
            vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end      , opts)
            vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end          , opts)
            vim.keymap.set('i', '<C-h>'      , function() vim.lsp.buf.signature_help() end  , opts)

        end)

        -- Use :LspZeroViewConfigSource sourcekit to see config options!
        require('lspconfig').sourcekit.setup({ })
        require('lspconfig').lua_ls.setup({ })
        require('lspconfig').nixd.setup({ })
        require('lspconfig').bashls.setup({ })

        lsp_zero.setup_servers({ 'sourcekit', 'lua_ls', 'nixd', 'bashls' }) '';
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
        [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh} 

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
    };

    loginExtra = "ponysay -b ascii -- '⭐ The Lord is FOR you and not AGAINST you! ⭐'";
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
        name = "Liga SFMono Nerd Font Medium"; # Check FontBook for the name because it must be verbatim
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
        background_opacity    = "0.93";
        background_tint       = 1;
        background            = "#ffffff";
#        background            = "#15202B";
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
            markdown
            markdown_inline
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
          plugin = mason-lspconfig-nvim;
          type   = "lua";
        }
        {
          plugin = mason-nvim;
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
