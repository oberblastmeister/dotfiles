files = {'racket', 'scheme', 'clojure'}
vim.api.nvim_create_autocmd("FileType", {
    pattern = files,
    group = vim.api.nvim_create_augroup('parinfer', {}),
    desc = 'load parinfer',
    callback = function()
      vim.cmd [[packadd parinfer-rust]]
    end
})
