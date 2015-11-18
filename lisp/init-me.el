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
  "w" 'save-buffer)

(evilem-default-keybindings "SPC")

;;;====================IDO====================
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;;;====================YAS====================
(yas-global-mode 1)

(provide 'init-me)
