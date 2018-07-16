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

(when (featurep! :emacs electric)
  (add-hook 'haskell-mode-hook 'electric-indent-local-mode))

;; Useful when using CamelCase with variable and function names.
(add-hook 'haskell-mode-hook 'subword-mode)

(add-hook 'haskell-mode-hook 'haskell-collapse-mode)

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))

(def-package! hlint-refactor
  :hook (haskell-mode . hlint-refactor-mode))

;; dante already defines a keybinding for this.
(def-package! attrap
  :commands (attrap-attrap))




