;; This is a place to put my own stuff
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-matchit)
(require-package 'evil-surround)
(require-package 'evil-nerd-commenter)
(require-package 'evil-jumper)
(require-package 'avy)
(require-package 'yasnippet)
(require-package 'company)
(require-package 'helm-c-yasnippet)
(require-package 'emmet-mode)
(require-package 'web-beautify)
(require-package 'rainbow-delimiters)

;;;====================EVIL====================
(setq evil-want-C-i-jump nil)
(require 'evil)
(require 'evil-leader)
(require 'evil-matchit)
(require 'evil-surround)

(evil-leader/set-leader ",")
(global-evil-leader-mode 1)
(setq evil-leader/in-all-states t)
(global-evil-surround-mode 1)
(setq evil-want-C-i-jump t)
(evil-jumper-mode t)
(evil-leader/set-key
  ;;; don't use o, because it's the namespace of org
  ","  'evil-repeat-find-char-reverse
  "."  'switch-to-previous-buffer
  "a"  'avy-goto-char-2
  "A"  'helm-apropos
  "b"  'helm-mini
  "ci" 'evilnc-comment-or-uncomment-lines'
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line'
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line'
  "C"  'ispell-word
  "d"  'delete-other-windows
  "D"  'delete-all-other-buffers
  "f"  'helm-projectile-find-file
  "F"  'helm-find-files
  "g"  'helm-projectile-ag
  "m"  'markdown-preview
  "nt" 'neotree-toggle
  "O"  'other-window
  "q"  'save-buffers-kill-terminal
  "r"  'split-window-right
  "S"  'delete-trailing-whitespace
  ;;; t is taken for helm-gtags
  "w"  'save-buffer
  "x"  'helm-M-x
  "y"  'helm-yas-complete
  "Y"  'helm-yas-create-snippet-on-region)

(global-evil-matchit-mode 1)
(evil-mode 1)

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
  Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun delete-all-other-buffers ()
  "Kill all other buffers"
  (interactive) (dolist (buffer (buffer-list))
                  (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
                    (kill-buffer buffer))))

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

;;;====================EMMET-MODE====================
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(evil-define-key 'insert emmet-mode-keymap (kbd "C-y") 'emmet-expand-line)
(evil-define-key 'insert emmet-mode-keymap (kbd "C-n") 'emmet-next-edit-point)
(evil-define-key 'insert emmet-mode-keymap (kbd "C-p") 'emmet-prev-edit-point)

;;;====================WEB-BEAUTIFY====================
(require 'web-beautify)
(eval-after-load 'js2-mode
                 '(add-hook 'js2-mode-hook
                            (lambda ()
                              (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))
(eval-after-load 'js
                 '(add-hook 'js-mode-hook
                            (lambda ()
                              (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))
(eval-after-load 'json-mode
                 '(add-hook 'json-mode-hook
                            (lambda ()
                              (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))
(eval-after-load 'sgml-mode
                 '(add-hook 'html-mode-hook
                            (lambda ()
                              (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))
(eval-after-load 'css-mode
  '(add-hook 'css-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))

;;;====================RAINBOW-DELIMITERS====================
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;;====================LOAD-MY-BASH-CONFIG====================
(setq explicit-bash-args '("--login" "--init-file" "~/.bashrc" "-i"))

;;;====================COMMON====================
(set-frame-parameter nil 'fullscreen 'fullboth)
(set-face-attribute 'default t :font "Courier New-18")
(add-to-list 'default-frame-alist '(font . "Courier New-18"))

(provide 'init-me)
