;;; tools/ebib/config.el -*- lexical-binding: t; -*-

(def-package! ebib
  :commands ebib
  :config
  (setq ebib-bibtex-dialect 'biblatex
        ebib-preload-bib-files '("/home/patrl/GitHub/bibliography/elliott_mybib.bib")))
