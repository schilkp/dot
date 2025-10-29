-- stylua: ignore
local M = {}
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep

-- stylua: ignore start
M.snippets = {
  s({ trig = "always_ff" }, {
    t({ "always_ff @(posedge clk_i or negedge rst_ni) begin", "" }),
    t({ "  if (!rst_ni) begin", "" }),
    t({ "    " }), i(0), t({ "", "" }),
    t({ "  end else begin", "" }),
    t({ "    ", "" }),
    t({ "  end", "" }),
    t({ "end", "" }),
  }),
  s({ trig = "header" }, {
    t({ "// ==== " }), i(0), t({ " =======================================================================" })
  }),
  s({ trig = "header_llvm" }, {
    t({ "//===----------------------------------------------------------------------===//", "" }),
    t({ "// " }), i(0), t({ "", "" }),
    t({ "//===----------------------------------------------------------------------===//", "" })
  }),
  s({ trig = "module" }, {
    t({ "module " }), i(1), t({ " #(", "" }),
    t({ ") (", "" }),
    t({ "    input logic clk_i,", "" }),
    t({ "    input logic rst_ni", "" }),
    t({ ");", "" }),
    t({ "  " }), i(0), t({ "", "" }),
    t({ "endmodule", "" })
  }),
  s({ trig = "dq_vars" }, {
    i(1), t("_d, "), rep(1), t({ "_q;", "" }),
    rep(1), t("_d = "), rep(1), t({ "_q;", "" }),
    rep(1), t({ "_q <= 'b0;", "" }),
    rep(1), t("_q <= "), rep(1), t({ "_d;", "" }),
  }),
  s({ trig = "dq" }, {
    i(1), t("_d, "), rep(1), t({ "_q;", "" }),
    t({ "", "" }),
    t({ "always_comb begin", "" }),
    t("  "), rep(1), t("_d = "), rep(1), t({ "_q;", "" }),
    t({ "end", "" }),
    t({ "", "" }),
    t({ "always_ff @(posedge clk_i or negedge rst_ni) begin", "" }),
    t({ "  if (!rst_ni) begin", "" }),
    t({ "    " }), rep(1), t({ "_q <= 'b0;", "" }),
    t({ "  end else begin", "" }),
    t({ "    " }), rep(1), t("_q <= "), rep(1), t({ "_d;", "" }),
    t({ "  end", "" }),
    t({ "end", "" }),
  }),
  s({ trig = "once" }, {
    t("`ifndef "), i(1), t({ "_SVH", "" }),
    t("`define "), rep(1), t({ "_SVH", "" }),
    i(0), t({ "", "" }),
    t("`endif // "), rep(1), t("_SVH")
  }),
}
-- stylua: ignore end

return M
