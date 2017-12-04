" Prefer a larger GUI
if has("gui_running")
  if &lines != 50
    set lines=50
  endif
  if &columns != 120
    set columns=120
  endif
endif
