local M = {}

M.spell_dir = vim.fs.normalize("~/.config/nvim/spell/")
M.spell_files = { "en.utf-8.spl", "de.utf-8.spl" }

-- Download a spellfile if it does not already exists:
local function download_spellfile(f)
  local spellfile_path = M.spell_dir .. "/" .. f
  local spellfile_url = "https://ftp.nluug.nl/pub/vim/runtime/spell/" .. f

  if vim.fn.filereadable(spellfile_path) == 0 then
    vim.print("Spellfile " .. f .. " missing! Downloading..")
    vim.cmd("!wget --no-verbose --no-check-certificate '" .. spellfile_url .. "' -P '" .. M.spell_dir .. "'")
    if vim.v.shell_error ~= 0 then
      vim.print("Warning: Failed to download!")
    end
  else
    vim.print("Spellfile " .. f .. " found.")
  end
end

-- Download all spellfiles:
function M.download_spellfiles()
  for _, spellfile in ipairs(M.spell_files) do
    download_spellfile(spellfile)
  end
end

function M.config_spellfiles()
  -- Register command to download missing spellfiles:
  vim.cmd("command DownloadSpellfiles lua require('schilk.config.spellfiles').download_spellfiles()")

  -- Check if any spellfiles are missing. If so, prompt to download them:
  for _, spellfile in ipairs(M.spell_files) do
    local spellfile_path = M.spell_dir .. "/" .. spellfile
    if vim.fn.filereadable(spellfile_path) == 0 then
      vim.print("Some spellfiles are missing. Call `:DownloadSpellfiles`.")
      break
    end
  end
end

return M
