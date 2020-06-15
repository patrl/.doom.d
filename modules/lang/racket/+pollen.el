;;; lang/racket/+pollen.el --- description -*- lexical-binding: t; -*-
;;;###if (featurep! +pollen)

(use-package! pollen-mode
  ;; :config
  ;; (when (featurep 'evil)
  ;;   (add-hook 'pollen-mode-hook #'evil-normalize-keymaps))
  )

(use-package! company-pollen
  :when (featurep! :completion company)
  :after pollen-mode
  :config
  (set-company-backend! 'pollen-mode 'company-pollen))
