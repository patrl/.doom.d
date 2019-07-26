;;; tools/ebib/config.el -*- lexical-binding: t; -*-

(after! ebib
  (setq ebib-bibtex-dialect 'biblatex
        ebib-preload-bib-files '("/home/patrl/repos/bibliography/elliott_mybib.bib")
        ebib-index-mode-map (make-sparse-keymap)
        ebib-entry-mode-map (make-sparse-keymap))
  (map! (:map (ebib-index-mode-map)
          :n "k" #'ebib-prev-entry
          :n "j" #'ebib-next-entry
          :n "l" #'ebib-next-database
          :n "h" #'ebib-prev-database
          :n "gg" #'ebib-goto-first-entry
          :n "G" #'ebib-goto-last-entry
          :n "q" #'ebib-quit
          :n "/" #'ebib-search
          :n "n" #'ebib-search-next
          :n "x" #'ebib-delete-entry

          :localleader
          :n "l" #'ebib-show-log
          :n "a" #'ebib-show-annotation
          :n "n" #'ebib-open-note
          )

        (:map (ebib-entry-mode-map)
          :n "k" #'ebib-prev-field
          :n "j" #'ebib-next-field
          :n "RET" #'ebib-edit-field
          :n "gg" #'ebib-goto-first-field
          :n "G" #'ebib-goto-last-field
          :n "q" #'ebib-quit-entry-buffer
          :n "y" #'ebib-yank-field-contents)))

