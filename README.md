# Setup

#### 1. Install Nix

Install the Nix Installer from [Determinate Systems](https://https://zero-to-nix.com/start/install)
Enter password when it wants to sudo
Confirm Y to proceed with installation.
Restart terminal and confirm Nix installed with:
```bash
nix doctor

/nix/nix-installer self-test
```

#### 2. Clone this repository

Change directory into home directory and if you have already a .config folder in your home directory, rename it.<br>
Otherwise,
> cd ~
>
> ls -a | grep '.config'
If no results turn up, you're good to go.

Clone this repo into the .config directory
> nix run nixpkgs#git clone https://github.com/kong4ndrew/config


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

