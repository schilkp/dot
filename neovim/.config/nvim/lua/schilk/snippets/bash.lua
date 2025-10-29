local M = {}

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

-- stylua: ignore start
M.snippets = {
  s({ trig = "basic_script" }, {
    t({ "#!/usr/bin/env bash", "" }),
    t({ '', "" }),
    t({ '# Fail on error code, unknown var, and propagate errors from pipes:', "" }),
    t({ 'set -euo pipefail', "" }),
  }),
  s({ trig = "cd_to_script_dir" }, {
    t({ "# Move to location of this script", "" }),
    t({ 'SCRIPT_DIR="$(realpath "$(dirname "$0")")"', "" }),
    t({ 'cd "$SCRIPT_DIR"', "" }),
  }),
}
-- stylua: ignore end

return M
