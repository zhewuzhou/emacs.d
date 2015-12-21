;;; init-org.el org plus evil

(require-package 'org-pomodoro)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-agenda-files (quote ("~/Dropbox/org"
                               "~/my-gtd")))

(require 'org)
(require 'evil-leader)
(require 'evil)

(evil-leader/set-key-for-mode 'org-mode
  "oa"  'org-agenda
  "oc"  'org-capture
  "od"  'org-deadline
  "on"  'org-narrow-to-subtree
  "oi"  '(lambda ()
           (interactive)
           (org-insert-property-drawer))
  "oo"  'org-open-at-point
  "ol"  'org-insert-link
  "op"  'org-pomodoro
  "os"  'org-set-tags-command
  "ot"  'org-todo
  "o$"  'org-archive-subtree)


(defun my/org-insert-scheduled-heading ()
  "Insert a new org heading scheduled for today."
  (interactive)
  (call-interactively 'org-insert-todo-heading)
  (org-schedule nil (format-time-string "%Y-%m-%d")))

(defun my/org-agenda-capture ()
  (interactive)
  (if (not (eq major-mode 'org-agenda-mode))
      (user-error "You cannot do this outside of agenda buffers")
    (let ((org-overriding-default-time (org-get-cursor-date)))
      (org-capture nil "t"))))

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "n" 'my/org-agenda-capture)))

(add-hook 'org-capture-mode-hook
          (lambda ()
            (evil-insert-state)))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c ,") 'org-time-stamp-inactive)
            (define-key org-mode-map (kbd "C-c i") 'my/org-insert-scheduled-heading)
            (define-key org-mode-map (kbd "C-c l") 'org-metaleft)
            (define-key org-mode-map (kbd "C-c r") 'org-metaright)
            (define-key org-mode-map (kbd "C-c I") 'org-insert-heading)
            (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
            (auto-fill-mode)
            (flyspell-mode)))

;;; states and faces
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "DOING(n)" "|" "DONE(d)")
              (sequence "BLOCKED(b@/!)" "REVIEW(r@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("DOING" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("BLOCKED" :foreground "orange" :weight bold)
              ("REVIEW" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

;;; org tags
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?H)
                            (:endgroup)
                            ("BLOCKED" . ?b)
                            ("REVIEW" . ?r)
                            ("PERSONAL" . ?p)
                            ("WORK" . ?W)
                            ("PRODUCTIVE" . ?P)
                            ("RESEARCH" . ?R)
                            ("DATA" . ?D)
                            ("LANG" . ?L)
                            ("OS" . ?S)
                            ("THEORY" . ?T)
                            ("CODING" . ?C)
                            ("BLOG" . ?B)
                            ("ORG" . ?O)
                            ("EMACS" . ?E)
                            ("INFLUENCE" . ?I)
                            ("NORANG" . ?N)
                            ("PROJECT" . ?w)
                            ("CANCELLED" . ?c))))

;;; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

;;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

(provide 'init-org)
;;; init-org.el ends here
