;; This is a place to put my own stuff
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'avy)
(require-package 'yasnippet)
(require-package 'company)

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
  "c" 'avy-goto-char-2
  "C" 'ispell-word
  "." 'switch-to-previous-buffer
  "g" 'magit-status
  "x" 'helm-M-x
  "b" 'helm-mini
  "F" 'helm-imenu
  "f" 'helm-find
  "o" 'delete-other-windows
  "O" 'other-window
  "s" 'ag-project
  "S" 'delete-trailing-whitespace
  "q" 'save-buffers-kill-terminal
  "e" 'eval-last-sexp
  "w" 'save-buffer)

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
  Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun kill-other-buffers ()
  "Kill all other buffers"
  (interactive) (dolist (buffer (buffer-list))
                  (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
                    (kill-buffer buffer))))

;;;====================YAS====================
(require 'yasnippet)
(yas-global-mode 1)

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
