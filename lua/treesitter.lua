require'nvim-treesitter.configs'.setup {

  ensure_installed = {"javascript", "typescript", "c", "rust", "python"},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
