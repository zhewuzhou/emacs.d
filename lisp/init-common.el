;; This is a place to config common editing stuff
(require-package 'yasnippet)
(require-package 'company)
(require-package 'helm-c-yasnippet)
(require-package 'emmet-mode)
(require-package 'rainbow-delimiters)

;;;====================DIMINISH====================
(after-load 'flycheck
  (diminish 'flycheck-mode))

(after-load 'flyspell
  (diminish 'flyspell-mode))

(after-load 'projectile
  (diminish 'projectile-mode))

(after-load 'company
  (diminish 'company-mode))

(after-load 'yasnippet
  (diminish 'yas-minor-mode))

(after-load 'helm-mode
  (diminish 'helm-mode))

(after-load 'ess
  (diminish 'auto-fill-function))

(after-load 'whitespace-cleanup-mode
  (diminish 'whitespace-cleanup-mode))

;;;====================YAS====================
(require 'yasnippet)
(setq yas-snippets-dir "~/.emacs.d/snippets")
(yas-global-mode 1)
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)

;;;====================COMPANY====================
(require 'company)
(setq company-dabbrev-downcase nil)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

                                        ; Make sure path company works
(delete 'company-files company-backends)
(add-to-list 'company-backends 'company-files)

;;;====================RAINBOW-DELIMITERS====================
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;;====================LOAD-MY-BASH-CONFIG====================
(setq explicit-bash-args '("--login" "--init-file" "~/.bashrc" "-i"))

;;;====================EMMET-MODE====================
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(evil-define-key 'insert emmet-mode-keymap (kbd "C-y") 'emmet-expand-line)
(evil-define-key 'insert emmet-mode-keymap (kbd "C-n") 'emmet-next-edit-point)
(evil-define-key 'insert emmet-mode-keymap (kbd "C-p") 'emmet-prev-edit-point)

;;;====================FONT====================
(set-frame-parameter nil 'fullscreen 'fullboth)
(set-face-attribute 'default t :font "Courier New-18")
(add-to-list 'default-frame-alist '(font . "Courier New-18"))

(provide 'init-common)
