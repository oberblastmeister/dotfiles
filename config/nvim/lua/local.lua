local function ft_opt(ft, option, value)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    group = vim.api.nvim_create_augroup('FtOptions', {}),
    desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
    callback = function()
      if type(option) == 'string' then
        assert(type(value) == 'string')
        vim.opt_local[option] = value
      elseif type(option) == 'function' then
        assert(value == nil)
        option()
      else
        error("invalid type for option")
      end
    end
  })
end


ft_opt({'lua'}, function()
  set_indent(ol, 2)
end)

ft_opt({'racket'}, function()
  set_indent(ol, 2)
  ol.commentstring = '; %s'
end)

ft_opt({'ocaml'}, function()
  set_indent(ol, 2)
end)
