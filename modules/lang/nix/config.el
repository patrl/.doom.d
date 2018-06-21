;;; lang/nix/config.el -*- lexical-binding: t; -*-

(def-package! company-nixos-options
  :when (featurep! :completion company)
  :after nix-mode
  :config (add-to-list 'company-backends 'company-nixos-options))
