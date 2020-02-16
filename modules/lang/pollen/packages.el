;; -*- no-byte-compile: t; -*-
;;; lang/pollen/packages.el

(package! pollen-mode)

(when (featurep! :completion company)
  (package! company-pollen))
