;;; tools/ebib/config.el -*- lexical-binding: t; -*-

(after! ebib
  (setq ebib-bibtex-dialect 'biblatex
        ebib-preload-bib-files '("/home/patrl/GitHub/bibliography/elliott_mybib.bib")

        ebib-index-mode-map (make-sparse-keymap))
  (map! (:map (ebib-index-mode-map)
          :n "k" #'ebib-prev-entry
          :n "j" #'ebib-next-entry
          :n "l" #'ebib-next-database
          :n "h" #'ebib-prev-database
          :n "gg" #'ebib-goto-first-entry
          :n "G" #'ebib-goto-last-entry
          :n "q" #'ebib-quit)))

