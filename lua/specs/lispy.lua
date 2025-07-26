return {
  {
    'guns/vim-sexp',
    init = function()
      vim.g.sexp_enable_insert_mode_mappings = false
      vim.g.sexp_filetypes = 'clojure,scheme,lisp,timl,fennel,racket'
      vim.g.sexp_mappings = {
        sexp_swap_list_backward = '',
        sexp_swap_list_forward = '',
        sexp_swap_element_backward = '',
        sexp_swap_element_forward = '',
        sexp_emit_head_element = '',
        sexp_emit_tail_element = '',
        sexp_capture_prev_element = '',
        sexp_capture_next_element = '',
      }
    end,
  },
  {
    'tpope/vim-sexp-mappings-for-regular-people',
    dependencies = { 'guns/vim-sexp' },
    ft = { 'fennel', 'query', 'clojure', 'racket', 'lisp' },
  },
}
