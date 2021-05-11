require'compe'.setup {
  enabled = true;
  autocomplete = false;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

vim.cmd[[
let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <CR> compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <c-x><c-x> compe#complete()
]]
