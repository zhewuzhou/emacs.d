(require-package 'ess)
(require 'ess-site)

(autoload 'R-mode "ess-site.el" "ESS" t)
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
(add-to-list 'auto-mode-alist '("\\.r$" . R-mode))

(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session
(add-hook 'R-mode-hook
          (lambda()
            (local-set-key (kbd "M-e")
                           (lambda ()
                             (interactive)
                             (unless (get-buffer "*R*")
                               (split-window-horizontally-instead)
                               (R)
                               (switch-window))
                             (ess-eval-region (point-min) (point-max) t)))))

(provide 'init-r)
