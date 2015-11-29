;;; init-org.el org plus evil

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-agenda-files (quote ("~/Dropbox/org"
                               "~/Personal")))

(when (and (maybe-require-package 'org)
           (maybe-require-package 'evil-leader)
           (maybe-require-package 'evil))

  (evil-leader/set-key-for-mode 'org-mode
    "I"  'org-time-stamp-inactive
    "c"  'org-capture
    "S"  'org-time-stamp
    "t"  'org-set-tags-command
    "T"  'org-todo
    "p"  '(lambda ()
            (interactive)
            (org-insert-property-drawer))
    "d"  'org-deadline
    "s"  'org-schedule
    "a"  'org-agenda
    "ns" 'org-narrow-to-subtree
    "$"  'org-archive-subtree)

  (evil-define-key 'normal org-mode-map (kbd "C-<") 'org-metaleft)
  (evil-define-key 'normal org-mode-map (kbd "C->") 'org-metaright)
  (evil-define-key 'insert org-mode-map (kbd "C-<") 'org-metaleft)
  (evil-define-key 'insert org-mode-map (kbd "C->") 'org-metaright)

  (add-hook 'org-mode-hook
            (lambda ()
              (define-key org-mode-map (kbd "C-c ,") 'org-time-stamp-inactive)
              (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
              (evil-define-key 'normal org-mode-map (kbd "C-\\") 'org-insert-heading)
              (evil-define-key 'insert org-mode-map (kbd "C-\\") 'org-insert-heading)
              (auto-fill-mode)
              (flyspell-mode))))

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
                            ("PERSONAL" . ?P)
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
                            ("NORANG" . ?N)
                            ("CANCELLED" . ?c))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

(provide 'init-org)
;;; init-org.el ends here
