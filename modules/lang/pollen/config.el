;;; lang/pollen/config.el -*- lexical-binding: t; -*-

(def-package! pollen-mode
  :mode (("\\.pp$" . pollen-mode)))

(def-package! company-pollen
  :when (featurep! :completion company)
  :after pollen-mode
  :config
  (set-company-backend! 'pollen-mode 'company-pollen))
