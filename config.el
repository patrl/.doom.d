;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; TODO get this correctly set by latex-bibtex-file
(setq bibtex-completion-bibliography '("~/GitHub/bibliography/elliott_mybib.bib"))
(setq bibtex-completion-library-path '("~/Dropbox/Library/"))
(setq ivy-bibtex-default-action 'ivy-bibtex-open-pdf)

(after! deft
  (setq deft-directory "~/Dropbox/deft"
        deft-use-filter-string-for-filename nil
        deft-use-filename-as-title nil
        deft-org-mode-title-prefix t))

(after! tex
  (setq-default TeX-engine 'xetex
                TeX-PDF-mode t))

(after! latex
    (map-put TeX-view-program-selection 'output-pdf '("Zathura"))
    ;; note that ths should probably affect the bibtex-completion-bibliography too.
    (setq +latex-bibtex-file "~/GitHub/bibliography/elliott_mybib.bib")
    (setq +latex-bibtex-dir "~/Dropbox/Library"))

;; TODO change repl handler to cabal just in case dante is installed.
;; (after! haskell-mode
  ;; (set-repl-handler! 'haskell-mode #'switch-to-haskell))

(map!
 (:leader
   (:desc "open" :prefix "o"
     :desc "APP: deft" :n "D" #'deft)

   (:desc "notes" :prefix "n"
     :desc "Search bibliography" :n "b" #'ivy-bibtex)
   ))
