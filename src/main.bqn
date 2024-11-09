⟨c⇐color, win⇐window, d⇐draw, key, mouse⟩ ← r ← •Import "../rayed-bqn/rayed.bqn"
raylib ← •Import "../rayed-bqn/ffi/raylib.bqn"

win_size ← 1200‿1200
win_pos ← 200‿200

font_size ← 80
message ← "Hello World!"
font ← @

_Start ← { Update _𝕣 𝕩:
  font↩r.font.LoadBQN 200

	win.SetSize win_size
	win.SetPos win_pos

	Update @
}

Update ← {𝕊:
  pos ← (win_size÷2) - ×⟜0.25 font_size × (≠message)‿1
  c.purple‿font‿font_size d.Text pos‿message

} d._withCanvas_ 32‿32‿32‿255


Update •_While_ (¬win.ShouldClose) _Start win._openAs "Template"
