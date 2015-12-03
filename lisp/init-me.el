;; This is a place to put my own stuff
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'avy)
(require-package 'yasnippet)
(require-package 'company)
(require-package 'helm-c-yasnippet)

;;;====================EVIL====================
(require 'evil-leader)
(evil-mode nil)
(require 'evil-leader)
(require 'evil)
(evil-leader/set-leader ",")
(evil-mode nil)
(global-evil-leader-mode 1)
(evil-mode 1)
(setq evil-leader/in-all-states t)
(evil-leader/set-key
  ;;; don't use o, because it's the namespace of org
  ","  'evil-repeat-find-char-reverse
  "."  'switch-to-previous-buffer
  "a"  'avy-goto-char-2
  "b"  'helm-mini
  "C"  'ispell-word
  "d"  'delete-other-windows
  "D"  'delete-all-other-buffers
  "e"  'eval-last-sexp
  "f"  'helm-projectile-find-file
  "F"  'helm-find
  "g"  'helm-projectile-ag
  "m"  'magit-status
  "nt" 'neotree-toggle
  "O"  'other-window
  "q"  'save-buffers-kill-terminal
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

;;;====================LOAD-MY-BASH-CONFIG====================
(setq explicit-bash-args '("--login" "--init-file" "~/.bashrc" "-i"))

(provide 'init-me)
