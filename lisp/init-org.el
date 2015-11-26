;;; init-org.el org plus evil

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

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

; org remember stuff
(setq org-agenda-text-search-extra-files '(agenda-archives))
(setq org-agenda-files '("~/Dropbox/org/agenda"))
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/templates/default-template.org")

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Dropbox/org/templates/default-template.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Dropbox/org/templates/default-template.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/Dropbox/org/templates/default-template.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Dropbox/org/templates/default-template.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/Dropbox/org/templates/default-template.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Dropbox/org/templates/default-template.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/Dropbox/org/templates/default-template.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Dropbox/org/templates/default-template.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

(provide 'init-org)
;;; init-org.el ends here
