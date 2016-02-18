;; This is the configuration for helm
(require-package 'helm)
(require-package 'helm-descbinds)

(helm-mode 1)
(setq helm-buffers-fuzzy-matching t)
(ido-mode -1)
(helm-descbinds-mode)

(provide 'init-helm)
