(use-package eclim
  :ensure t
  :init
  (progn
    (require 'eclim)
    (setq eclimd-autostart t)
    )
  :config
  (defun my-java-mode-hook ()
    (eclim-mode t)
    (smartparens-mode t))

  (add-hook 'java-mode-hook 'my-java-mode-hook)
  (custom-set-variables
   '(eclim-eclipse-dirs '("~/eclipse/eclipse"))
   '(eclim-executable "~/eclipse/plugins/org.eclim_2.7.2/bin/eclim")
  ))

(defun eclim-my-java-macro ()
  ;; type string and get it replace upon M-RET.
  (interactive)
  ;; set main java method
  (evil-ex-substitute
   (- (point) 9)
   (point)
   (list "java-main")
   "public static void main(String[] args) {\n}")
  ;; set println
  (evil-ex-substitute
   (point)
   (+ (point) 6)
   (list "Sysout")
   "System.out.println();")
  (evil-normal-state)
  (evil-end-of-line)
  (indent-according-to-mode))
(define-key evil-insert-state-map (kbd "M-RET") 'eclim-my-java-macro)

(provide 'init-eclim-java)
