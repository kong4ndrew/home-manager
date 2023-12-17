# Setup

#### 1. Install Nix

Install the Nix Installer from [Determinate Systems](https://https://zero-to-nix.com/start/install)<br>
Enter password when it wants to sudo.<br>
Confirm Y to proceed with installation.<br>
Restart terminal and confirm Nix installed with:<br>

```bash
nix doctor

/nix/nix-installer self-test
```

#### 2. Clone this repository

Change directory into home directory.<br>
If you don't already have one, create a .config folder<br>.
Set your working directory to .config/.<br>
Clone this repo into it.

```bash

cd ~

mkdir .config && cd .config

nix run nixpkgs#git clone https://github.com/kong4ndrew/home-manager

```

#### 3. Activate Home-manager

```bash

nix run home-manager/master -- switch --flake ~/.config/home-manager

```

#### 4. Setup kitty as a GUI application

Reboot your computer.<br>
Open terminal and run `kitty` as a command.<br>
It should open an instance of kitty. Now exit with `exit`.<br>
Now open your home directory on Finder with `⌘ + ⇧ + h`(Command + Shift + H).<br>
Navigate to the Applications/Home Manager Apps folder within your home directory.<br>
You should see kitty as an application alias. Open it and right-click on the icon in the dock,<br>
    choosing `Options -> Keep in Dock` to keep it in your dock.


# To-do

 1. Build the flake and home.nix on another macOS/Linux machine to see if it's really reproducible with just a few nix commands

 2. Customize night fox with slightly more contrasting colors.

 3. Add automatic light and dark mode feature
  
 4. Look into cmp keybindings and see if that's something you want to customize

 5. Add ability to run xcode projects from command-line?

 6. Add welcome/setup instructions on the readme.

 7. Add nvim-tree?

 8. 

# Done

- ~~Add support for Swift LSP~~
- ~~Add LSP support for other languages~~
- ~~Add a consistent background for light and dark~~
- ~~Modularize config files~~
<br>
<br>
<br>
<br>
<br>

## Quick Markdown Syntax Reference

<br>

A link [kong4ndrew](https://github.com/kong4ndrew/config)

<br>

- Unordered list item
- Another one
    - Indented list item
    - Another one

<br>

*Italicized text* <br>
**Bold text** <br>
***Bold and italicized text*** <br>

<br>

> Blockquotes

> A blockquotes paragraph
>
> .

<br>

# Heading level 1
## Heading level 2
### Heading level 3
#### Heading level 4
##### Heading level 5
###### Heading level 6

<br>

<p>This is a paragraph
</p>

<br>


<p>This is a paragraph.<br> It also has a line break in it.</p>

