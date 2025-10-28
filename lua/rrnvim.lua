local M = {}

local defaults = {
    old_word = "",
    new_word = "",
    context = nil,
    recursive = false,
    verbosity = nil,
}

local function rr_notify(arg)
  vim.notify("rr.nvim:" .. arg, vim.log.levels.INFO, {timeout=2000})
end

local function run_rr(args)
    local cmd = {'rr'}
    for _, v in ipairs(args) do
        if v ~= nil then
            table.insert(cmd, v)
        end
    end

    return vim.fn.system(cmd)
end


function M.replace_for_this_buffer(old_word, new_word)
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == "" then
      rr_notify("file without associated buffer")
      return
    end
    run_rr({old_word or defaults.old_word, new_word or defaults.new_word, buf_name})
end

function M.replace_for_this_directory(old_word, new_word, recursive)
    local cwd = vim.fn.getcwd()
    run_rr({old_word or defaults.old_word, new_word or defaults.new_word, cwd, recursive})
end

local function get_selected_word()
  local mode = vim.api.nvim_get_mode().mode

  if mode ~= "v" and mode ~= "V" then
    return nil
  end

  local save_reg = vim.fn.getreg('"')
  local save_regtype = vim.fn.getregtype('"')

  vim.cmd('normal! "vy')

  local selection = vim.fn.getreg('v')

  vim.fn.setreg('"', save_reg, save_regtype)

  return selection
end


local function get_new_word()
  return vim.fn.input("new word: ")
end

local function global_word_replace()
  local old_word = get_selected_word() or ""
  local new_word = get_new_word() or ""
  local path = vim.api.nvim_buf_get_name(0)
  local context = vim.fn.fnamemodify(vim.fn.resolve(path), ":p:h")

  if old_word == "" then
    rr_notify("No words selected.")
    return
  end
  if new_word == "" then
    rr_notify("No word to replace.")
    return
  end
  if path == "" then
    rr_notify("buffer is not associated with a file.")
    return
  end


  run_rr({old_word, new_word, context})

  vim.api.nvim_buf_call(0, function()
    vim.cmd("edit!")
  end)

  rr_notify("replacement completed and buffer reloaded.")

end



local function local_word_replace()
  local old_word = get_selected_word()
  vim.print("old word:" .. old_word)
  local new_word = vim.fn.input("new word: ")
  local buf_name = vim.api.nvim_buf_get_name(0)
  if not old_word or old_word == "" then
    vim.print("rr.nvim: no word selected")
    return
  end

  if not new_word or new_word == "" then
    vim.print("rr.nvim: no new word provided")
    return
  end

  if buf_name == "" then
    vim.print("rr.nvim: buffer has no file")
    return
  end
  run_rr({old_word, new_word, buf_name})
  rr_notify("word replaced successfully.")
    vim.api.nvim_buf_call(0, function()
    vim.cmd("edit!")
  end)
end

function M.setup()
  vim.keymap.set('x', 'lwr',local_word_replace)
  vim.keymap.set('x', 'lgr', global_word_replace)
    vim.api.nvim_create_user_command('RR', function(opts)
        local fargs = opts.fargs
        run_rr(fargs)
    end, { nargs = '*' })
end

return M

