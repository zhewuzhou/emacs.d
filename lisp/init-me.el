;; This is a place to put my own stuff
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-easymotion)
(require-package 'yasnippet)

;;;====================EVIL====================
(evil-mode 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'switch-to-previous-buffer
  "x" 'helm-M-x
  "b" 'helm-mini
  "f" 'helm-imenu
  "o" 'delete-other-windows
  "s" 'delete-trailing-whitespace
  "w" 'save-buffer)

(evilem-default-keybindings "SPC")

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;;====================YAS====================
(yas-global-mode 1)

(provide 'init-me)
