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
   (- (point) 5)
   (point)
   (list "jmain")
   "public static void main(String[] args) {\n}")
  ;; set println
  (evil-ex-substitute
   (point)
   (+ (point) 7)
   (list "println")
   "System.out.println();")
  (evil-ex-substitute
   (point)
   (+ (point) 5)
   (list "print")
   "System.out.print();")
  (evil-ex-substitute
   (point)
   (+ (point) 4)
   (list "fori")
   "for (int i = 0; i < xx; i++) {\n}")
  (evil-normal-state)
  (evil-end-of-line)
  (indent-according-to-mode))
(define-key evil-insert-state-map (kbd "M-RET") 'eclim-my-java-macro)

(provide 'init-eclim-java)
