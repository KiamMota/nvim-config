local M = {}

function M.setup()
  vim.api.nvim_create_user_command('RR', function(opts)
      local output = vim.fn.system(vim.list_extend({'rr'}, opts.fargs))
      print(output)
  end, { nargs = '+' })
end

return M

