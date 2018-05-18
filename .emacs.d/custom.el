(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-frame-alist (quote ((undecorated . t))))
 '(desktop-path (quote ("~/.emacs.d/desktop" "~")))
 '(desktop-save nil)
 '(desktop-save-mode nil)
 '(direx:closed-icon "[►]")
 '(direx:open-icon "[▼]")
 '(eclim-eclipse-dirs (quote ("c:/Users/jakub/eclipse/eclipse.exe")))
 '(eclim-executable "c:/Users/jakub/eclipse/eclim.bat")
 '(package-selected-packages
   (quote
    (smartparens company-emacs-eclim eclim emacs-eclim slime-company slime aggressive-indent aggresive-indent company clj-refactor cider clojure-refactor clojure-mode-extra-font-locking clojure-mode evil-org paredit helm direx powerline-evil key-chord airline-themes monokai-theme evil-leader evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-fringe-good-face ((t (:foreground "#A6E22E"))))
 '(minibuffer-prompt ((t (:background "#272822" :foreground "#A6E22E" :box nil))))
 '(show-paren-match ((t (:inverse-video t :weight normal)))))

;; UTILITIES
;; Comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; Set-up backup directory
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

;; Desktop Sessions
(defvar my-desktop-session-dir
  (concat (getenv "HOME") "/.emacs.d/desktop-sessions/"))

(defvar my-desktop-session-name-hist nil)

(defun my-desktop-get-session-name (prompt)
  (completing-read prompt (and (file-exists-p my-desktop-session-dir)
                               (directory-files my-desktop-session-dir))
                          nil nil nil my-desktop-session-name-hist))

(defun session-s (&optional name)
  ;; SAVE
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Save session as: ")))
  (make-directory (concat my-desktop-session-dir name) t)
  (desktop-save (concat my-desktop-session-dir name) t))

(defun session-r (&optional name)
  ;; READ
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Load session: ")))
  (desktop-read (concat my-desktop-session-dir name)))

;; Startup Desktop for init.el
(defvar my-desktop-startup-dir
  (concat (getenv "HOME") "/.emacs.d/desktop-startup/"))

(defun my-startup-save ()
  (interactive)
  (desktop-save (concat my-desktop-startup-dir) t))

(defun my-startup-read ()
  (interactive)
  (desktop-read my-desktop-startup-dir))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
