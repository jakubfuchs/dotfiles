;; Always use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package nlinum-relative
  :ensure t
  :config
  (nlinum-relative-setup-evil)
  (setq nlinum-relative-current-symbol ">>> ")
  (setq nlinum-relative-redisplay-delay 0)
  ;; (add-hook 'prog-mode-hook #'nlinum-relative-mode)
  )
;; EMACS transparent
;; (set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;; (set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))

(custom-set-variables
 '(default-frame-alist '((undecorated . t))))

;; auto resizing windows
(use-package golden-ratio
  :ensure t
  :init
  (progn
    (require 'golden-ratio)
    ;; (golden-ratio-mode 1)
    )
  (setq golden-ratio-extra-commands
      (append golden-ratio-extra-commands
	      '(evil-window-next)
	      '(evil-window-left)
	      '(evil-window-right)
	      '(evil-window-up)
	      '(evil-window-down)))
  :config)

(cond
 ;; ((find-font (font-spec :name "Ubuntu Mono"))
  ;; (set-face-font 'default "Ubuntu Mono-10"))
 ;; ((find-font (font-spec :name "Menlo"))
  ;; (set-face-font 'default "Menlo-10"))
 ((find-font (font-spec :name "Monospace"))
  (set-face-font 'default "Monospace-10"))
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-face-font 'default "DejaVu Sans Mono-10"))
 ((find-font (font-spec :name "Lucida sans Typewriter"))
  (set-face-font 'default "Lucida sans Typewriter-11")))

(add-to-list 'load-path "~/.emacs.d/custom-themes")
;;(require 'color-theme-sanityinc-solarized)
;; (load-theme 'wombat)
(require 'monokai-theme)

;; (use-package monokai-theme
  ;; :ensure t
  ;; :config
  ;; )

;; (use-package arjen-grey-theme
  ;; :ensure t
  ;; :config
  ;; (load-theme 'arjen-grey t))

(use-package powerline-evil
  :ensure t
  :config
  (powerline-evil-vim-color-theme)
  ;;(powerline-evil-center-color-theme)
  ;;(powerline-evil-vim-theme)
  )

(use-package airline-themes
  :ensure t
  :init
  (progn
    (require 'airline-themes)
    (load-theme 'airline-molokai t)
    ;; (load-theme 'airline-simple t)
    )
  :config
  (setq powerline-utf-8-separator-left        #xe0b0
        powerline-utf-8-separator-right       #xe0b2
        airline-utf-glyph-separator-left      #xe0b0
        airline-utf-glyph-separator-right     #xe0b2
        airline-utf-glyph-subseparator-left   #xe0b1
        airline-utf-glyph-subseparator-right  #xe0b3
        airline-utf-glyph-branch              #xe0a0
        airline-utf-glyph-readonly            #xe0a2
        airline-utf-glyph-linenumber          #xe0a1)
  )

;; Helm

(use-package helm
  :ensure t
  :init
  (require 'helm-config)
  (setq helm-quick-update t)
  (setq helm-split-window-in-side-p nil)
  (setq helm-ff-file-name-history-use-recent t)
  ;; :diminish helm-mode
  :commands helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level)

  (defun esc-quits-helm ()
    (define-key helm-map [escape] 'helm-keyboard-quit))
  (add-hook 'helm-after-initialize-hook 'esc-quits-helm)

  (defun hide-cursor-in-helm-buffer ()
    "Hide the cursor in helm buffers"
    (with-helm-buffer
      (setq cursor-in-non-selected-windows nil)))
  (add-hook 'helm-after-initialize-hook 'hide-cursor-in-helm-buffer))

;; Direx
(use-package direx
  :ensure t
  :config
  (evil-ex-define-cmd "lsd" 'direx:jump-to-directory)
  (evil-define-key 'normal direx:direx-mode-map (kbd "j") 'direx:next-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "k") 'direx:previous-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "J") 'direx:next-sibling-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "K") 'direx:previous-sibling-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "RET") 'direx:maybe-find-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "TAB") 'direx:toggle-item)
  ;; (evil-define-key 'normal direx:direx-mode-map (kbd "^") 'direx:up-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "u") 'direx:up-item)
  (evil-define-key 'normal direx:direx-mode-map (kbd "o") 'direx:find-item-other-window)
  (evil-define-key 'normal direx:direx-mode-map (kbd "E") 'direx:expand-item-recursively)
  (evil-declare-key 'normal direx:direx-mode-map (kbd "f")   'direx:find-item)
  (evil-declare-key 'normal direx:direx-mode-map (kbd "V")   'direx:view-item-other-window)
  (evil-declare-key 'normal direx:direx-mode-map (kbd "v")   'direx:view-item)
  (evil-declare-key 'normal direx:file-map (kbd "+")   'direx:create-directory)
  (evil-define-key 'normal direx:direx-mode-map (kbd "g") 'direx:refresh-whole-tree)
  (add-hook 'direx:direx-mode-hook 'hl-line-mode)
  )

;; Dired
(use-package dired
  :config
  (setq ls-lisp-dirs-first t
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        wdired-allow-to-change-permissions t)
  (add-hook 'dired-mode-hook 'hl-line-mode)
  (define-key dired-mode-map (kbd "C-x C-q") #'wdired-change-to-wdired-mode))

;; Company
(use-package company
  :ensure t
  :defer t
  :init
  (global-company-mode)
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0.4)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "M-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-.") 'company-show-location)
  (define-key company-active-map (kbd "M-j") #'company-select-next)
  (define-key company-active-map (kbd "M-k") #'company-select-previous))

;; Company for eclim
(use-package company-emacs-eclim
  :ensure t
  :config
  (company-emacs-eclim-setup))

;; Parentheses

(use-package paredit
  :ensure t
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
    (add-hook 'clojure-mode-hook 'paredit-mode)
    (add-hook 'clojurescript-mode-hook 'paredit-mode)
    (add-hook 'clojurec-mode-hook 'paredit-mode)
    (add-hook 'cider-repl-mode-hook 'paredit-mode)))

;; smartparens variant:
(use-package smartparens-config
    :ensure smartparens
    :config
    (progn
      (add-hook 'inferior-python-mode-hook 'smartparens-mode)
      (add-hook 'python-mode-hook 'smartparens-mode)))
    ;; (progn
      ;; (show-smartparens-global-mode t)))

;; (add-hook 'python-mode-hook 'turn-on-smartparens-strict-mode)
;; (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
;; (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

(use-package highlight-numbers
  :ensure t
  :init
  (progn
    (add-hook 'prog-mode-hook 'highlight-numbers-mode)))

(use-package adoc-mode
  :ensure t
  :init
  (progn
    (add-to-list 'auto-mode-alist
                 (cons "\\.asciidoc\\'" 'adoc-mode))
    (add-to-list 'auto-mode-alist
                 (cons "\\.txt\\'" 'adoc-mode))))

(provide 'init-ui)
