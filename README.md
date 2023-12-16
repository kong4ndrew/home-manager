# Setup

#### 1. Install Nix

Install the Nix Installer from [Determinate Systems](https://https://zero-to-nix.com/start/install)<br>
Enter password when it wants to sudo<br>
Confirm Y to proceed with installation.<br>
Restart terminal and confirm Nix installed with:<br>

```bash
nix doctor

/nix/nix-installer self-test
```

#### 2. Clone this repository

Change directory into home directory.<br>
If you have already a .config folder in your home directory, rename it.<br>
If no results turn up when you `ls grep`, you should be good to go.<br>

```bash
cd ~

ls -a | grep '.config'
```

Clone this repo into your home directory

```bash
nix run nixpkgs#git clone https://github.com/kong4ndrew/.config
```

#### 3. Switch into your first home-manager generation


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

