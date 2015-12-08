(require-package 'json-mode)
(require-package 'js2-mode)
(require-package 'skewer-mode)

;;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(provide 'init-javascript)
