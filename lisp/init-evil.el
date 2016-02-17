;; This is a place to put my own stuff
(require-package 'dash)
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-matchit)
(require-package 'evil-surround)
(require-package 'evil-nerd-commenter)
(require-package 'evil-jumper)
(require-package 'avy)

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
(evil-jumper-mode t)
(evil-define-key 'normal evil-jumper-mode-map (kbd "C-f") #'evil-jumper/forward)
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
  ;;; e is for ediff
  "ea" 'diff-region-tag-selected-as-a
  "eb" 'diff-region-compare-with-b
  "f"  'helm-projectile-find-file
  "F"  'helm-find-files
  "g"  'helm-projectile-ag
  "l"  'helm-projectile-find-file-in-known-projects
  "m"  'markdown-preview
  "nt" 'neotree-toggle
  "O"  'other-window
  "q"  'save-buffers-kill-terminal
  "r"  'split-window-right
  "s"  'helm-projectile-switch-project
  "S"  'delete-trailing-whitespace
  ;;; t is taken for helm-gtags
  "w"  'save-buffer
  "W"  'save-some-buffers
  "x"  'helm-M-x
  "y"  'helm-yas-complete
  "Y"  'helm-yas-create-snippet-on-region
  "z"  'current-term)

(global-evil-matchit-mode 1)
(evil-mode 1)

(defun find-term-buffer ()
  (interactive)
  (car (-filter (lambda (b)
                  (eq 'term-mode (buffer-local-value 'major-mode b)))
                (buffer-list))))

;;; this is the setting for kill buffer without confirmation
;;; from http://emacs.stackexchange.com/questions/14509/kill-process-buffer-without-confirmation
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(defun kill-term ()
  (interactive)
  (if (find-term-buffer)
    (kill-buffer (find-term-buffer)))
    )

(defun current-term ()
  (interactive)
  (if (find-term-buffer)
    (switch-to-buffer (buffer-name (find-term-buffer)))
    (ansi-term (getenv "SHELL") (projectile-project-root))
    ))

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

(provide 'init-evil)
