local M = {}

local ls = require("luasnip")

-- stylua: ignore start
M.snippets = {
  ls.parser.parse_snippet({ trig = "main" }, [[
  def main():
      $0
      pass

  if __name__ == '__main__':
      main()
  ]]),
}
-- stylua: ignore end

return M
