;; -*- no-byte-compile: t; -*-
;;; lang/racket/packages.el

(package! racket-mode :pin "bd4c8cf3ce")

(when (featurep! +pollen)
(package! pollen-mode :pin "d0a3359")
(when (featurep! :completion company)
  (package! company-pollen :pin "d0a3359")))
