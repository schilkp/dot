local M = {}

local ls = require("luasnip")

-- stylua: ignore start
M.snippets = {
    ls.parser.parse_snippet({ trig = "tests" }, [[
    #[cfg(test)]
    mod tests {
        use super::*;

        #[test]
        fn $1() {
            $0
        }
    }
  ]]),

    ls.parser.parse_snippet({ trig = "header" }, [[
    // ==== $0 =======================================================================
  ]]),
}
-- stylua: ignore end

return M
