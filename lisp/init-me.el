;; This is a place to put my own stuff
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-easymotion)
(require-package 'yasnippet)

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
  "," 'evil-repeat-find-char-reverse
  "." 'switch-to-previous-buffer
  "x" 'helm-M-x
  "b" 'helm-mini
  "f" 'helm-imenu
  "o" 'delete-other-windows
  "O" 'other-window
  "s" 'delete-trailing-whitespace
  "q" 'save-buffers-kill-terminal
  "e" 'eval-last-sexp
  "w" 'save-buffer)

(evilem-default-keybindings "SPC")

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;;====================YAS====================
(require 'yasnippet)
(yas-global-mode 1)

(provide 'init-me)
