local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.add_snippets("go", {
    s("eh", {
        t("func "), i(1, "name"), t("("), i(2, ""), t(") echo.HandlerFunc {"),
        c(3, { t(""), t({"", "\t// Optional: add types or code here", ""}) }),
        t({"", "\treturn func(c echo.Context) error {", "\t\t"}), i(4, "// TODO: implement"), t({"", "\t}", "}", ""}),
        i(0)
    }),
})
