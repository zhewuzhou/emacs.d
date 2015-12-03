;; This is the configuration for helm
(require-package 'helm)

(helm-mode 1)
(setq helm-buffers-fuzzy-matching t)
(ido-mode -1)

(provide 'init-helm)
