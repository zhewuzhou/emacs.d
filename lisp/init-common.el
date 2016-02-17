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

;;; from http://emacs.stackexchange.com/questions/7908/how-to-make-yasnippet-and-company-work-nicer
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (cond
    ((minibufferp)
     (minibuffer-complete))
    (t
      (indent-for-tab-command)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
        (if (check-expansion)
          (progn
            (company-manual-begin)
            (if (null company-candidates)
              (progn
                (company-abort)
                (indent-for-tab-command)))))))))

(defun tab-complete-or-next-field ()
  (interactive)
  (if (or (not yas/minor-mode)
          (null (do-yas-expand)))
    (if company-candidates
      (company-complete-selection)
      (if (check-expansion)
        (progn
          (company-manual-begin)
          (if (null company-candidates)
            (progn
              (company-abort)
              (yas-next-field))))
        (yas-next-field)))))

(defun expand-snippet-or-complete-selection ()
  (interactive)
  (if (or (not yas/minor-mode)
          (null (do-yas-expand))
          (company-abort))
    (company-complete-selection)))

(defun abort-company-or-yas ()
  (interactive)
  (if (null company-candidates)
    (yas-abort-snippet)
    (company-abort)))

(global-set-key [tab] 'tab-indent-or-complete)
(global-set-key (kbd "TAB") 'tab-indent-or-complete)
(global-set-key [(control return)] 'company-complete-common)

(define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
(define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

(define-key yas-minor-mode-map [tab] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(define-key yas-keymap [tab] 'tab-complete-or-next-field)
(define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
(define-key yas-keymap (kbd "C-e") 'yas-next-field)
(define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)

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

;;;====================COMMON-SETTING====================
;;; this is the setting for kill buffer without confirmation
;;; from http://emacs.stackexchange.com/questions/14509/kill-process-buffer-without-confirmation
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

;;; because terminal is not GUI could not share clipboard as normal-about-screen
;;; from http://stackoverflow.com/questions/5288213/how-can-i-paste-the-selected-region-outside-of-emacs
;;; now you could do copy by select->M w inside Emacs->C v anywhere as you want
(setq interprogram-cut-function
      (lambda (text &optional push)
        (let* ((process-connection-type nil)
               (pbproxy (start-process "pbcopy" "pbcopy" "/usr/bin/pbcopy")))
          (process-send-string pbproxy text)
          (process-send-eof pbproxy))))

(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)

(provide 'init-common)
