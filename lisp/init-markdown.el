(require-package 'markdown-mode)

(after-load 'whitespace-cleanup-mode
  (push 'markdown-mode whitespace-cleanup-mode-ignore-modes))

(add-hook 'markdown-mode-hook 'turn-on-orgtbl)
(setq markdown-command "~/.rvm/gems/ruby-2.2.2/bin/kramdown")

(provide 'init-markdown)
