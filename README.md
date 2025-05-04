# Joshie's personal NeoVim setup

Starting point from kickstart with extra customization.
This config is not made for others. But feel free to take inspiration or ~~steal~~ borrow some of my ideas/code.

## Setup

This setup does not work out of the box and requires you to download a few dependencies.

### Quick Look at Plugins

#### custom behavior

* remap
  * key mappings. In some cases, keymaps are defined in specific plugin setups.

#### plugins

* auto format
  * conform.nvim; I made a custom command for python formatting. Use Ruff's Isort if possible
* completion
  * basically just kickstart's setup. But added command pallet auto complete
* lsp
  * lsp-config and Mason
* playground
  * scratch files and a code runner (contains a plugin I created)
* plugins
  * all other plugins that do not require special configs or are not important enough to pull out
* snacks
  * Extra QoL plugins. Requires the gh CLI and `gh ext install meiji163/gh-notify`
* tree
  * tree UI for when opening on `nvim .`. Does call for modifications to default tree view.
* treesitter
  * treesitter

### Blog posts

I created a few blog post tutorials for setting up specific things.

* [Spell checker on code](https://coderjoshdk.github.io/tutorials/2024-01-15-Setting-Up-Spellcheck-on-Code-in-NeoVim.html)
* [Python things to keep in mind] (coming soon)
