;; This is a place to put my own stuff
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'avy)
(require-package 'yasnippet)
(require-package 'company)
(require-package 'helm-c-yasnippet)
(require-package 'emmet-mode)
(require-package 'web-beautify)
(require-package 'evil-matchit)

;;;====================EVIL====================
(require 'evil-leader)
(require 'evil-leader)
(require 'evil)
(require 'evil-matchit)

(evil-leader/set-leader ",")
(global-evil-leader-mode 1)
(global-evil-matchit-mode 1)
(evil-mode 1)
(setq evil-leader/in-all-states t)
(evil-leader/set-key
  ;;; don't use o, because it's the namespace of org
  ","  'evil-repeat-find-char-reverse
  "."  'switch-to-previous-buffer
  "a"  'avy-goto-char-2
  "A"  'helm-apropos
  "b"  'helm-mini
  "C"  'ispell-word
  "d"  'delete-other-windows
  "D"  'delete-all-other-buffers
  "f"  'helm-projectile-find-file
  "F"  'helm-find
  "g"  'helm-projectile-ag
  "m"  'magit-status
  "nt" 'neotree-toggle
  "O"  'other-window
  "q"  'save-buffers-kill-terminal
  "r"  'split-window-right
  "S"  'delete-trailing-whitespace
  "w"  'save-buffer
  "x"  'helm-M-x
  "y"  'helm-yas-complete
  "Y"  'helm-yas-create-snippet-on-region)

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

;;;====================YAS====================
(require 'yasnippet)
(setq yas-snippets-dir "~/.emacs.d/snippets")
(yas-global-mode 1)
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)

;;;====================COMPANY====================
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
                      (define-key company-active-map (kbd "M-n") nil)
                      (define-key company-active-map (kbd "M-p") nil)
                      (define-key company-active-map (kbd "C-n") #'company-select-next)
                      (define-key company-active-map (kbd "C-p") #'company-select-previous))

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

;;;====================LOAD-MY-BASH-CONFIG====================
(setq explicit-bash-args '("--login" "--init-file" "~/.bashrc" "-i"))

(provide 'init-me)
