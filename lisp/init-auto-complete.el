(require-package 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(provide 'init-auto-complete)
