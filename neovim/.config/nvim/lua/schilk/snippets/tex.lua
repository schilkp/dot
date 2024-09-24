local M = {}

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

M.snippets = {
    ls.parser.parse_snippet({ trig = "env" }, [[
    \begin{$1}
        $0
    \end{$1}
    ]]),

    ls.parser.parse_snippet({ trig = "todo" }, [[
    \textbf{\textcolor{red}{TODO}}$0
    ]]),

    ls.parser.parse_snippet({ trig = "fig" }, [[
    \begin{figure}[htbp]
        \centering
        \includegraphics[width=0.80\linewidth]{fig/$1}
        \captionof{figure}{$0}
        \label{fig:$2}
    \end{figure}
    ]]),

    ls.parser.parse_snippet({ trig = "fig_dual" }, [[
    \begin{figure}[htbp]
        \centering
        \begin{minipage}{.5\textwidth}
            \centering
            \includegraphics[width=\linewidth]{$1}
            \captionof{figure}{$3}
            \label{fig:$2}
        \end{minipage}%
        \begin{minipage}{.5\textwidth}
            \centering
            \includegraphics[width=\linewidth]{fig/$4}
            \captionof{figure}{$0}
            \label{fig:$5}
        \end{minipage}
    \end{figure}
    ]]),

    ls.parser.parse_snippet({ trig = "tasks" }, [[
    \begin{TasksBox}
        \begin{itemize}[leftmargin=1em]
            \item $0
        \end{itemize}
    \end{TasksBox}
    ]]),

    ls.parser.parse_snippet({ trig = "lst" }, [[
    \begin{listing}[htb]
        $0
        \vspace{-1.5\baselineskip}
        \caption{$1}
        \label{lst:$2}
    \end{listing}
    ]]),

    ls.parser.parse_snippet({ trig = "lst_minted" }, [[
    \begin{listing}[htb]
        \begin{minted}{$1}
            $0
        \end{minted}
        \vspace{-1.5\baselineskip}
        \caption{$2}
        \label{lst:$3}
    \end{listing}
    ]]),

    ls.parser.parse_snippet({ trig = "table" }, [[
    \begin{table}[htbp]
      \begin{center}
        \begin{tabular}{ $1 }
        $0 \\\\
        \end{tabular}
      \end{center}
    \end{table}
    ]]),

    ls.parser.parse_snippet({ trig = "inline_minted" }, [[
    \mintinline{$1}{$0}
    ]]),

}

return M
