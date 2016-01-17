;; This is a place to config input stuff
(require-package 'chinese-pyim)
(require-package 'popup)
(require 'pos-tip)

(require 'chinese-pyim)
(setq default-input-method "chinese-pyim")
(global-set-key (kbd "C-c i") 'toggle-input-method)
(global-set-key (kbd "C-c ;") 'pyim-toggle-full-width-punctuation)
(setq pyim-dicts '((:name "default" :file "~/.emacs.d/pyim/dicts/pyim-bigdict.pyim" :coding utf-8-unix :dict-type pinyin-dict)))
(setq-default pyim-english-input-switch-function
                            'pyim-dynamic-english-input-function)
(setq pyim-dicts-manager-scel2pyim-command "/usr/local/bin/scel2pyim")
(setq pyim-use-tooltip t)

(require 'chinese-pyim-company)
(setq pyim-company-max-length 6)

(provide 'init-input)
