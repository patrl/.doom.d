;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(load! "+bindings.el")

(setq magit-process-find-password-functions '(magit-process-password-auth-source))

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
  (setq-default TeX-engine 'xetex))

(setq markdown-command "pandoc --standalone --css=http://benjam.info/pan-am/styling.css -V lang=en -V highlighting-css= --mathjax --from=markdown+smart --to=html5")

(setq +latex-bibtex-file "~/GitHub/bibliography/elliott_mybib.bib")
(setq +latex-bibtex-dir "~/Dropbox/Library")
(setq ivy-bibtex-default-action 'ivy-bibtex-open-pdf)

(setq doom-font (font-spec :family "SF Mono" :adstyle "Retina" :size 11.0)
      ;; doom-variable-pitch-font (font-spec :family "Input Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-big-font (font-spec :family "SF Mono" :size 18.0)
      doom-theme 'doom-one)

