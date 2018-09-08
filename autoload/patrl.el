;;; ~/.doom.d/autoload/patrl.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +patrl/tangle-dotfiles ()
  (when (equal (buffer-file-name)
               (expand-file-name "~/nixos-config/README.org"))
    (org-babel-tangle)
    (message "Dotfiles tangled")))

;;;###autoload
(add-hook 'after-save-hook #'+patrl/tangle-dotfiles)
