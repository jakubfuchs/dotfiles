(defun config-evil-leader ()
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "," 'compile
    ;; "r" 'inf-clojure-switch-to-repl
    ;; "a" 'helm-projectile-ag
    ;; "," 'helm-projectile-find-file
    ;; "p" 'helm-projectile-switch-project
    ;; "t" 'direx-project:jump-to-project-root
    "o" 'delete-other-windows
    "O" 'delete-other-frames
    "p" 'paredit-mode
    "T" 'toggle-transparency
    "t" 'toggle-truncate-lines
    "D" 'dired
    "d" 'direx:jump-to-directory
    ;; "i" 'parinfer-toggle-mode
    ";" 'comment-or-uncomment-region
    "x" 'org-capture
    "g" 'golden-ratio-mode
    "w" 'evil-write
    "b" 'helm-mini
    "f" 'switch-to-buffer-other-frame
    "Q" 'kill-this-buffer
    "q" 'evil-delete-buffer
    "<backtab>" 'previous-buffer
    "TAB" 'next-buffer
    ;; ">" 'sp-slurp-hybrid-sexp
    "l" 'nlinum-mode
    "(" 'paredit-wrap-round
    "s" 'paredit-meta-doublequote
    ">" 'paredit-forward
    "<" 'paredit-backward)

  ;; mapping for Eclim-Java
  (evil-leader/set-key-for-mode 'java-mode
    "e" 'eclim-run-class)
  
  ;; mapping for elisp scratch
  (evil-leader/set-key-for-mode 'lisp-interaction-mode
    ")" 'elisp-my-print-last-sexp
    "." 'eval-defun
    "e" 'eval-buffer)

  (defun elisp-my-print-last-sexp ()
    "run the command to enter evil-insert, then eval-print-last-sexp"
    (interactive)
    (evil-append 1)
    (eval-print-last-sexp)
    (evil-normal-state))

  ;; mapping for clisp coding
  (evil-leader/set-key-for-mode 'lisp-mode
    "e" 'slime-compile-and-load-file
    "." 'slime-compile-defun
    ")" 'slime-eval-defun
    "r" 'slime-switch-to-output-buffer)
  ;; mapping for clisp/slime REPL
  (evil-leader/set-key-for-mode 'slime-repl-mode
    "c" 'slime-switch-to-scratch-buffer)

  ;; mapping for clojure coding
  (evil-leader/set-key-for-mode 'clojure-mode
    "v" 'cider-jump-to-var
    ")" 'cider-my-eval-last-sexp
    "." 'cider-eval-defun-at-point
    "e" 'cider-my-save-and-load
    "c" 'cider-switch-to-last-clojure-buffer
    "r" 'cider-switch-to-repl-buffer)
  ;; mapping for clojure REPL
  (evil-leader/set-key-for-mode 'cider-repl-mode
    "c" 'cider-switch-to-last-clojure-buffer))

(defun config-evil ()
  ;; CZ keyboard numbers-issue and hacks
  ;; (define-key evil-normal-state-map (kbd "$") 'evil-repeat)
  (define-key evil-normal-state-map (kbd "$") 'evil-repeat-find-char)
  (define-key evil-motion-state-map (kbd ";") 'evil-end-of-line)
  ;; (define-key evil-motion-state-map " " nil)

  ;; (windmove-default-keybindings)
  (define-key evil-normal-state-map (kbd "C-w C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-w C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-w C-j") 'evil-window-down)

  (define-key evil-motion-state-map (kbd "C-w C-l") 'evil-window-right)
  (define-key evil-motion-state-map (kbd "C-w C-h") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-w C-k") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-w C-j") 'evil-window-down)

  ;; use tab in evil normal mode to go through buffers or delete them
  (define-key evil-normal-state-map (kbd "C-w C-<tab>") 'evil-prev-buffer)
  (define-key evil-normal-state-map (kbd "C-w <tab>") 'evil-next-buffer)
  (define-key evil-normal-state-map (kbd "C-w C-q") 'evil-delete-buffer)
  (define-key evil-motion-state-map (kbd "C-w C-<tab>") 'evil-prev-buffer)
  (define-key evil-motion-state-map (kbd "C-w <tab>") 'evil-next-buffer)
  (define-key evil-motion-state-map (kbd "C-w C-q") 'evil-delete-buffer)

  ;; esc ALWAYS quits
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (global-set-key [escape] 'keyboard-quit)


  (define-key evil-insert-state-map (kbd "M-l") 'company-capf)
)

(use-package evil
  :ensure t
  :commands (evil-mode evil-define-key)
  :config
  (add-hook 'evil-mode-hook 'config-evil)
  (evil-mode 1)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (config-evil-leader)

  (use-package key-chord
    :ensure t
    :config
    (key-chord-mode 1)
    (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
    (key-chord-define evil-insert-state-map "kj" 'evil-normal-state))

;;  (use-package evil-orgmode
;;    :ensure t
;;    :config
;;    (add-hook 'orgmode-hook 'evil-org-mode)
;;    (evil-org-set-key-theme '(navigation insert textobjects additional calendar)))

;;  (use-package evil-org-agenda
;;    :ensure t
;;    :config
;;    (evil-org-agenda-set-keys))
  ))

(provide 'init-evil)
