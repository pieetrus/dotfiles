return {{
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local parsers = { 'c_sharp', 'lua', 'vim', 'vimdoc', 'query', 'razor' }
    require('nvim-treesitter').install(parsers)

    -- the main branch does not enable highlighting by itself
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'cs', 'lua', 'vim', 'razor' },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}}
