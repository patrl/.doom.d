;;; lang/nix/config.el -*- lexical-binding: t; -*-

(def-package! nix-mode
  :mode ("\\.nix\\'" "\\.nix.in\\'")
  :config
  (set-company-backend! 'nix-mode 'company-nixos-options)
  (map! :map nix-mode-map
        :localleader
        :n "f" #'nix-update-fetch
        :n "p" #'nix-format-buffer
        :n "r" #'nix-repl-show
        :n "s" #'nix-shell
        :n "b" #'nix-build
        :n "u" #'nix-unpack
        (:when (featurep! :completion helm)
          :n "o" #'helm-nixos-options)))

(def-package! nix-drv-mode
  :ensure nix-mode
  :mode "\\.drv\\'")

(def-package! nix-shell
  :ensure nix-mode
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))

(def-package! nix-repl
  :ensure nix-mode
  :commands (nix-repl))

(def-package! nix-update
  :commands (nix-update-fetch))
