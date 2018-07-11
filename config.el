;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; (setq magit-process-find-password-functions '(magit-process-password-auth-source))
(setq org-directory (expand-file-name "~/Dropbox/org/")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-bullets-bullet-list '("#"))

(after! deft
  (setq deft-directory "~/Dropbox/deft"
        deft-default-extension "org"
        deft-use-filter-string-for-filename nil
        deft-use-filename-as-title nil
        deft-org-mode-title-prefix t))

(after! tex
  (setq-default TeX-engine 'xetex
                TeX-PDF-mode t)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(after! markdown
 (setq markdown-command "pandoc --from=markdown-smart --to=html --katex --highlight-style=haddock"))

(setq +latex-bibtex-file "~/GitHub/bibliography/elliott_mybib.bib")
(setq +latex-bibtex-dir "~/Dropbox/Library")
(setq ivy-bibtex-default-action 'ivy-bibtex-open-pdf)

(setq doom-font (font-spec :family "Input Mono" :size 11.0)
      doom-variable-pitch-font (font-spec :family "Input Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-big-font (font-spec :family "Input Mono" :size 18.0)
      doom-theme 'doom-one-light)

(map!
 (:leader
   (:desc "open" :prefix "o"
     :desc "APP: deft" :n "D" #'deft)

   (:desc "project" :prefix "p"
     :desc "Make project" :n "m" #'+make/run
     :desc "Search in project" :n "s" #'counsel-projectile-rg)

   (:desc "notes" :prefix "n"
     :desc "Search bibliography" :n "b" #'ivy-bibtex)
   ))
