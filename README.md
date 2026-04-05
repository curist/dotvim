# Intro

My babe.

## Local overrides

Machine-specific values live in `lua/dot/config.lua`.
To override them locally, create an untracked `lua/dot/local.lua`:

```lua
return {
  paths = {
    playground = vim.uv.os_homedir() .. '/src',
    twinkle_root = vim.uv.os_homedir() .. '/src/rust/twinkle',
    twinkle_lsp = vim.uv.os_homedir() .. '/src/rust/twinkle/target/release/twk',
    twinkle_parser = vim.uv.os_homedir() .. '/src/rust/twinkle/tree-sitter-twinkle',
    notes = vim.uv.os_homedir() .. '/notes',
  },
  terminal = {
    shell = vim.env.SHELL,
    wait_wrapper = 'petc',
  },
}
```

# Outro

```sh
git clone https://github.com/curist/dotvim ~/.config/nvim
```
