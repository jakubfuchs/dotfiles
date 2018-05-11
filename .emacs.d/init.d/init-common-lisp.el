(use-package slime
  :ensure t
  :init
  :config
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package slime-company
  :ensure t
  :config
  (slime-setup '(slime-fancy slime-company)))

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(provide 'init-common-lisp)
