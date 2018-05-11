;; evil-org
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; org settings
(add-hook 'org-mode-hook 'nlinum-relative-mode)
(setq org-startup-indented t)
(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n!)" "|" "DONE(d!)" "CANCELED(c@/!)")))

(setq org-todo-keyword-faces
      '(("NEXT" . (:foreground "yellow" :weight bold))))

(add-hook 'org-agenda-mode-hook
	  (lambda ()
	    ;; racket-run
      (define-key org-agenda-mode-map (kbd "j") 'org-agenda-next-item)
	    (define-key org-agenda-mode-map (kbd "k") 'org-agenda-previous-item)))

(provide 'init-org)
