" In terminal mode, change the cursor colour for insert mode
if g:os != "Darwin" && &term =~ "xterm-256color" && !has("gui_running")
  " Use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " Use a grey/white cursor otherwise
  let &t_EI = "\<Esc>]12;\#c0c0c0\x7"
end
