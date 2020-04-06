;;; ~/.doom.d/autoload/patrl.el -*- lexical-binding: t; -*-

;;;###autoload
(defun browse-org-directory ()
  "Browse the files in org-directory."
  (interactive)
  (doom-project-browse (expand-file-name org-directory)))
