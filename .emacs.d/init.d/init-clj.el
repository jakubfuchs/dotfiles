;; auto dependencies
(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

;; clojure-mode
(use-package clojure-mode
  :ensure t
  :init
  (add-hook 'clojure-mode-hook 'cider-mode)
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
  (add-hook 'clojure-mode-hook #'subword-mode)
  :config)

;; clojure-mode-extra-font-locking
(require 'clojure-mode-extra-font-locking)

;; clj-refactor
(use-package clj-refactor
  :init
  (add-hook 'clojure-mode-hook
            (lambda ()
              (clj-refactor-mode 1)))
  :config)

;; aggressive indenting
;; CAUSING EDITOR TO FREEZE WHEN WORKING WITH DEBUGGING/CIDER *ERROR* BUFFER
;; (use-package aggressive-indent
;; :ensure t
;; :config)
;; (require 'aggressive-indent)
;; (global-aggressive-indent-mode 1)
;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; cider
(use-package cider
  :ensure t
  :init
  (add-hook 'cider-mode-hook
            '(lambda ()
               (local-set-key (kbd "RET") 'newline-and-indent)))
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook
            '(lambda ()
               (evil-local-set-key 'insert (kbd "M-RET") 'cider-repl-newline-and-indent)
               (evil-local-set-key 'normal (kbd "M-RET") 'cider-repl-newline-and-indent)))
  :config
  (progn
    (setq cider-repl-display-help-banner nil)
    (setq cider-repl-history-file "~/.emacs.d/cider-history")
    (setq cider-repl-display-in-current-window t)
    )
  )

;; testings & evals
(defun cider-my-save-and-load ()
  "runs the command that saves and compiles the cider buffer"
  (interactive)
  (save-buffer)
  (cider-load-buffer))

;; debuggin utils
(defun cider-my-eval-last-sexp ()
  "runc the command to enter evil-insert, then cider-eval-last-sexp"
  (interactive)
  (evil-append 1)
  (cider-eval-last-sexp)
  (evil-normal-state))

(provide 'init-clj)
