(require-package 'go-mode)
(require-package 'company-go)

(require 'go-mode)

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(add-hook 'before-save-hook 'gofmt-before-save) ;auto format when save

(provide 'init-go)
