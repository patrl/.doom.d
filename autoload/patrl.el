;;; ~/.doom.d/autoload/patrl.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +patrl/deft-brain ()
  "Use `deft' for files in `org-brain-path'."
  (interactive)
  (let ((deft-directory org-brain-path)
        (deft-recursive t)
        (deft-use-filename-as-title t)
        (deft-extensions '("org")))
    (deft)))

;;;###autoload
(defun org-brain-insert-resource-icon (link)
  "Insert an icon, based on content of org-mode LINK."
  (insert (format "%s "
                  (cond ((string-prefix-p "http" link)
                         (cond ((string-match "wikipedia\\.org" link)
                                (all-the-icons-faicon "wikipedia-w"))
                               ((string-match "github\\.com" link)
                                (all-the-icons-octicon "mark-github"))
                               ((string-match "vimeo\\.com" link)
                                (all-the-icons-faicon "vimeo"))
                               ((string-match "youtube\\.com" link)
                                (all-the-icons-faicon "youtube"))
                               (t
                                (all-the-icons-faicon "globe"))))
                        ((string-prefix-p "brain:" link)
                         (all-the-icons-fileicon "brain"))
                        (t
                         (all-the-icons-icon-for-file link))))))

;;;###autoload
(add-hook 'org-brain-after-resource-button-functions #'org-brain-insert-resource-icon)

;;;###autoload
(defun aa2u-buffer ()
  (aa2u (point-min) (point-max)))

;;;###autoload
(add-hook 'org-brain-after-visualize-hook #'aa2u-buffer)

;;;###autoload
(defun writing-mode ()
  (interactive)
  (writeroom-mode 1)
  (blink-cursor-mode)
  (visual-line-mode 1)
  (display-line-numbers-mode -1)
  (setq truncate-lines nil)
  (setq global-hl-line-mode nil))
