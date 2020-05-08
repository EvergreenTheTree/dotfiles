c.fonts.default_family = 'Misc Ohsnap'
c.fonts.default_size = '11pt'
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.sans_serif = "Noto Sans"

c.session.default_name = "Default"
c.auto_save.session = True
c.session.lazy_restore = True

c.content.autoplay = False

c.scrolling.smooth = True

c.editor.command = ["nvim-qt", "{file}", "--", "-c", "normal {line}G{column0}l"]

config.source('nord-qutebrowser.py')
