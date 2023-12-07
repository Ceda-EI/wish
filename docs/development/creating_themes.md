# Creating Themes

Themes need to define the following variables.

+ `WISH_DEFAULT_FG`
+ `WISH_DEFAULT_BG`

Plugins will fallback to these variables if they are not themed.

Themes also need to define variables for plugins. For each plugin named `abc`,
the theme needs to define `WISH_ABC_BG` and `WISH_ABC_FG`. Themes can
optionally iterate over `WISH_PLUGINS` array to ensure to theme all elements.
Check existing [themes](https://gitlab.com/ceda_ei/wish/tree/main/themes).
