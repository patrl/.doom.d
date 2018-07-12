;; -*- no-byte-compile: t; -*-
;;; lang/latex/packages.el

(package! auctex)
(package! adaptive-wrap)

;; Optional module features:

(when (featurep! +latexmk)
  (package! auctex-latexmk))

(when (featurep! +preview-pane)
  (package! latex-preview-pane))

(package! company-auctex)
(package! company-reftex)
(package! ivy-bibtex)
(package! company-math)
(package! ebib)


