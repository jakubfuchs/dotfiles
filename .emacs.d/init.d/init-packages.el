(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; PACKAGES USED
(require 'init-evil)
(require 'init-ui)
(require 'init-org)
(require 'init-emacs-lisp)
(require 'init-clj)
(require 'init-common-lisp)
(require 'init-eclim-java)

(provide 'init-packages)
