;;; ~/.doom.d/autoload/patrl.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +patrl/tangle-dotfiles ()
  "If the current file is in '~/.dots', the code blocks are tangled"
  (when (equal (file-name-directory (directory-file-name buffer-file-name))
               (concat (getenv "HOME") "/.dots/"))
    (org-babel-tangle)
    (message "%s tangled" buffer-file-name)))

;;;###autoload
(add-hook 'after-save-hook #'+patrl/tangle-dotfiles)
