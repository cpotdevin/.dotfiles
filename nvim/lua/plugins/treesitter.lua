return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- No-op for parsers that are already installed
      require('nvim-treesitter').install { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end
          -- Fails silently when no parser is installed for the filetype
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end
  }
}
