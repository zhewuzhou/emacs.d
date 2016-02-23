(require 'xscheme)
(require 'evil-leader)

(evil-leader/set-key-for-mode 'scheme-mode
  "e" '(lambda ()
         (interactive)
         (if (get-buffer "*scheme*")
             (kill-buffer "*scheme*"))
         (split-window-horizontally-instead)
         (run-scheme "scheme")
         (switch-window)
         (xscheme-send-buffer)))

(provide 'init-scheme)
