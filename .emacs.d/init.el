(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'load-path (expand-file-name "init.d" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(require 'init-packages)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(fset 'yes-or-no-p 'y-or-n-p)
(setq desktop-load-locked-desktop t)
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
;; (setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq visible-bell t)
(setq ring-bell-function 'ignore)
(blink-cursor-mode t)
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(column-number-mode t)
(setq tab-width 2)
(setq tramp-default-method "ssh")
(put 'dired-find-alternate-file 'disabled nil)
(global-auto-revert-mode 1)
;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; STARTUP SESSION
;; Makes *scratch* empty.
(setq initial-scratch-message
      (concat ";; NOTHING IS WORSE THAN AN ITCH YOU CAN NEVER\n"
              ";; ╔═╗┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬\n"
              ";; ╚═╗│  ├┬┘├─┤ │ │  ├─┤\n"
              ";; ╚═╝└─┘┴└─┴ ┴ ┴ └─┘┴ ┴"))
;; Removes *scratch* from buffer after the mode has been set.
;; (defun remove-scratch-buffer ()
  ;; (if (get-buffer "*scratch*")
      ;; (kill-buffer "*scratch*")))
;; (add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)
;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; CUSTOM PACKAGES
(add-to-list 'load-path "~/.emacs.d/custom.d")
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(push '("\\.\\(?:frm\\|\\(?:ba\\|cl\\|vb\\)s\\)\\'" . visual-basic-mode)
      auto-mode-alist)

;; Initialize my custom startup desktop
(my-startup-read)
