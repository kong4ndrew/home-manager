# Setup

❗WARNING: Nix is highly addictive and sustained use may provoke thoughts on declaratively configuring life. Do NOT țᚴꃢʯؼย...<br><br>
⭐ Alright, let's go ahead and get a working configuration of [Nix, Home-manager, kitty, and Neovim] on your **Intel macOS** system.

#### 1. Install Nix

- Install the Nix Installer from [Determinate Systems](https://https://zero-to-nix.com/start/install).<br>
- Enter your computer's password when it wants to sudo.<br>
- Confirm `Y` to proceed with installation.<br>
- Restart terminal and confirm Nix installed with:<br>

```bash
nix doctor                   # [PASS] PATH contains only one nix version...

/nix/nix-installer self-test # INFO Successfully tested Nix install in all discovered shells. shells=["sh", "bash", "zsh"]
```

#### 2. Clone this repository

- Change directory into home directory.<br>
- If you don't already have one, create a `.config` folder.<br>
- Set your working directory to `.config/`.<br>
- Clone this Github repo into it.

```bash

cd ~

mkdir .config && cd .config

nix run nixpkgs#git clone https://github.com/kong4ndrew/home-manager

```

#### 3. Change username and home directory name

- In your terminal, change working directory into `~/.config/home-manager`<br>
- Open `home.nix` file with vim.<br>

```bash
cd ~/.config/home-manager

vim home.nix                  # Open home.nix with Vim

```

- Find and replace 'andrewkong' with your computer's username.<br>
- Find where it says `username = ...` and `homeDirectory = ...` and confirm this is correct for your computer.<br>
- Now do the find and replace of usernames for the flake.nix file as well.<br>
*Note `:` is how you begin a command in vim or neovim.*

```vim

:%s/andrewkong/yourUsername/g " In this file, find all instances of 'andrewkong' and replace it with 'yourUsername'

:w                            " Write (Save)

:e flake.nix                  " Edit flake.nix

:%s/andrewkong/yourUsername/g 

:wq                           " Write and quit

/loginExtra                   " Find where it says loginExtra and then customize your own ponysay login message inside the single quotes '...'

```

#### 3. Activate Home-manager

```bash

nix run home-manager/master -- switch --flake ~/.config/home-manager

```

#### 4. Setup kitty as a GUI application

- Reboot your computer.<br>
- Open terminal and run `kitty` as a command.<br>
- It should open an instance of kitty. Now exit with `exit`.<br>
- Now open your home directory on Finder with `⌘ + ⇧ + h`(Command + Shift + h).<br>
- Navigate to the `Applications/Home Manager Apps` folder within your home directory.<br>
- You should see kitty as an application alias.<br>
- Open it and right-click on the icon in the dock, choosing `Options -> Keep in Dock` to keep it in your dock.

#### 5. Switching, rollbacks, system updates, flake updates, garbage collector etc.

##### After modifying configuration or declaring desired installed packages on your home.nix, you can activate it by:

```bash

home-manager switch --flake ~/.config/home-manager

# or

hm                            # (A shell alias that was set in home.nix)

# or 

home-manager switch --flake . # (If you are already cd'ed into ~/.config/home-manager)

```


##### If you messed something up and want to rollback to a previous home-manager generation:

```bash

home-manager generations                             # 2023-12-16 12:00 : id 1 --> /nix/store/someHash-home-manager-generation

/nix/store/someHash-home-manager-generation/activate # Copy the path of the generation you want to rollback to and append 'activate'.

```

##### After performing system updates, your zshenv, located in /etc/zshenv might get replaced and Nix might not work. In that case, Nix Installer has a dedicated command to get it working again: 

```bash

/nix/nix-installer repair

```
##### To update dependencies and packages:

```bash

cd ~/.config/home-manager     # cd into wherever your flake.nix file is

nix flake update              # Note this only updates your flake.lock, but will NOT activate it

home-manager switch --flake . # Switching into your flake with home-manager will activate it

```
##### To remove home-manager generations and garbage collect unused binaries/packages/environments:

```bash

home-manager generations                   # List home-manager generations

home-manager remove-generations $(seq x y) # Remove whichever generations you want. 
                                           # To remove a whole sequence of generations from 'x' to 'y', replace x and y to select desired range.

nix store gc                               # Activate garbage collection on your current Nix store.

```


#### 6. Uninstall

You may see a few nix-related folders lying around. 
Whether you choose to delete them or not, it will not affect your system.

```bash

home-manager uninstall       # Uninstall home-manager as a user-level config/package manager

/nix/nix-installer uninstall # Uninstall nix as a global package manager

```

# To-do

1. How're you supposed to keep updated to this flake?

2. Add support in the flake for arm darwin and arm/intel linux

3. Add automatic light and dark mode feature

5. Add ability to run xcode projects from command-line?

7. Add nvim-tree?
  
4.

6. 

8. 

# Done

- ~~Add support for Swift LSP~~
- ~~Add LSP support for other languages~~
- ~~Add a consistent background for light and dark~~
- ~~Modularize config files~~
- ~Add welcome/setup instructions on the readme.~
- ~Look into cmp keybindings and see if that's something you want to customize~
- ~Build the flake and home.nix on another macOS/Linux machine to see if it's really reproducible with just a few nix commands~
- ~Customize night fox with slightly more contrasting colors.~
