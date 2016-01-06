;;; Setting up my tags system for easier browse source code
(require-package 'helm-gtags)
(require 'evil-leader)
(evil-leader/set-key
  "tg"  'helm-gtags-create-tags
  "tu"  'helm-gtags-update-tags
  "ts"  'helm-gtags-select
  "td"  'helm-gtags-dwim
  "tp"  'helm-gtags-parse-file)

(provide 'init-tags)
