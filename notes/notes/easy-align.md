# Basic:

 - Select
 - 'ga'
 - Use interactive prompt


# Interactive Promt:

## Modifiers:


| Key           | Function                                      |
| -             | -                                             |
| `<Enter>`     | Iterate between left-center-right align mode. |
| `1/2/3/...`   | Around Nth occurance of delimiter.            |
| `-/-1/-2/...` | Around Nth-last occurance of delimiter.       |
| `*`           | Around all delimiters.                        |
| `**`          | Left-right alternating around all delimiters. |

## Options:

| Key       | Option             | Values                                                     |
| -         | -                  | -                                                          |
| `CTRL-F`  | `filter`           | Input string (`[gv]/.*/?`)                                 |
| `CTRL-I`  | `indentation`      | shallow, deep, none, keep                                  |
| `CTRL-L`  | `left_margin`      | Input number or string                                     |
| `CTRL-R`  | `right_margin`     | Input number or string                                     |
| `CTRL-D`  | `delimiter_align`  | left, center, right                                        |
| `CTRL-U`  | `ignore_unmatched` | 0, 1                                                       |
| `CTRL-G`  | `ignore_groups`    | `[]`, `['String']`, `['Comment']`, `['String', 'Comment']` |
| `CTRL-A`  | `align`            | Input string (`/[lrc]+\*{0,2}/`)                           |
| `CTRL-P`  | `N/A`              | Change to Interactive mode.                                |
| `<Left>`  | `stick_to_left`    | `{ 'stick_to_left': 1, 'left_margin': 0 }`                 |
| `<Right>` | `stick_to_left`    | `{ 'stick_to_left': 0, 'left_margin': 1 }`                 |
| `<Down>`  | `*_margin`         | `{ 'left_margin': 0, 'right_margin': 0 }`                  |


## Finish:

- Delimiter Key:

| Key       | Function                                                 |
| -         | -                                                        |
| `<Space>` | Whitespace                                               |
| `=`       | Operators with equals sign (`=`, `==`, `+=` , `!=`, ...) |
| `:`       | JSON/YAML                                                |
| `.`       | Multi-line method chaining                               |
| `,`       | Multi-line method arguments                              |
| `&`       | LaTeX tables                                             |
| `#`       | Ruby/Python comments                                     |
| `"`       | Vim comments                                             |
| `<Bar>`   | Markdown Table                                           |

- Regex [CTRL-X]
