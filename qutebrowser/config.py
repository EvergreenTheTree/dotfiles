c.fonts.default_family = 'Iosevka Fixed'
c.fonts.default_size = '10pt'
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.sans_serif = "Noto Sans"

c.session.default_name = "Default"
c.auto_save.session = True
c.session.lazy_restore = False

c.content.autoplay = False

c.scrolling.smooth = True

c.tabs.favicons.scale = 0.9
c.tabs.padding = {"bottom": 4, "left": 7, "right": 7, "top": 3}

c.editor.command = ["nvim-qt", "{file}", "--", "-c", "normal {line}G{column0}l"]

c.colors.webpage.bg = "#3b4252"

c.colors.webpage.prefers_color_scheme_dark = True

config.source('nord-qutebrowser.py')
