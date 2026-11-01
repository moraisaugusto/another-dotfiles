# GTK 4.20+ on Wayland only handles dead keys/compose through an input method
# (ibus/fcitx). Without one, force GTK's built-in compose implementation so
# accents (and ~/.XCompose) work in GTK apps such as Ghostty.
export GTK_IM_MODULE=simple
