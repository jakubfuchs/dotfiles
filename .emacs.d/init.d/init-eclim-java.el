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

(provide 'init-eclim-java)
