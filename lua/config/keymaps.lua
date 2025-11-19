vim.keymap.set("n", "<Tab>", "$la")
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

local function MoverBufferVerticalmente()
  vim.keymap.set("", "<A-Up>", function()
    vim.cmd("m .-2")
  end)
  vim.keymap.set("", "<A-Down>", function()
    vim.cmd("m .+1")
  end)
end

-- x vira V no modo normal  

vim.keymap.set("n", "x", "V", { noremap = true, silent = false })

-- duplicar linha

vim.keymap.set("n", "<C-d>", function() vim.cmd("t-1") end, { noremap = true, silent = false })

local function NavegacaoBuffer()
  vim.keymap.set("n", "<A-Right>", function()
    vim.cmd("wincmd l")
  end, {})
  vim.keymap.set("n", "<A-Left>", function()
    vim.cmd("wincmd h")
  end, {})
  vim.keymap.set("n", "<S-Up>", function()
    vim.cmd("wincmd k")
  end, {})
  vim.keymap.set("n", "<S-Down>", function()
    vim.cmd("wincmd j")
  end, {})
end

  vim.keymap.set("n", "<S-Tab>", ":bnext<CR>", {})

vim.schedule(function()
  NavegacaoBuffer()
  MoverBufferVerticalmente()
end)
