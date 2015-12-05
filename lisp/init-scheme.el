(require 'xscheme)
(require 'evil-leader)

(evil-leader/set-key-for-mode 'scheme-mode
                              "e"  'xscheme-send-buffer)

(provide 'init-scheme)
