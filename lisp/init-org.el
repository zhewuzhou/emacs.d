;;; init-org.el org plus evil

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(when (and (maybe-require-package 'org)
           (maybe-require-package 'evil-leader)
           (maybe-require-package 'evil))

  (setq org-agenda-text-search-extra-files '(agenda-archives))
  (setq org-agenda-files '("~/Dropbox/org/"))

  (evil-leader/set-key-for-mode 'org-mode
                                "t"  'org-time-stamp-inactive
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
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(provide 'init-org)
;;; init-org.el ends here
