local M = {}

function M.config()
    local luasnip = require('luasnip')
    luasnip.add_snippets('c', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('cpp', require('schilk.snippets.c').snippets);
    luasnip.add_snippets('tex', require('schilk.snippets.tex').snippets);
    luasnip.add_snippets('python', require('schilk.snippets.python').snippets);
    luasnip.add_snippets('rust', require('schilk.snippets.rust').snippets);
    luasnip.add_snippets('lua', require('schilk.snippets.lua').snippets);
    luasnip.add_snippets('json', require('schilk.snippets.json').snippets);
end

return M
