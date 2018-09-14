;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Patrick D. Elliott"
      user-mail-address "patrick.d.elliott@gmail.com")

(load! "+bindings.el")

(setq org-directory (expand-file-name "~/Sync/org/")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-highlight-latex-and-related '(latex)
      org-bullets-bullet-list '("#"))

(after! deft
  (setq deft-directory "~/Sync/deft"))

;; nix tweaks
(after! nix-mode
  (setq nix-indent-function 'nix-indent-line))

(setq bibtex-completion-library-path "~/Sync/library/"
      helm-bibtex-full-frame nil
      bibtex-completion-pdf-symbol ""
      +latex-bibtex-file "~/GitHub/bibliography/elliott_mybib.bib"
      +latex-viewers `(pdf-tools zathura))

;; (setq ivy-bibtex-default-action 'ivy-bibtex-open-pdf)

(after! tex
  (setq-default TeX-engine 'xetex))

;; enable unicode-math completion:
(setq +latex-enable-unicode-math t)

;; ensures that unicode symbol completion only happens in math-mode
(after! latex
  (add-hook! 'LaTeX-mode-hook
      (setq-local company-math-allow-unicode-symbols-in-faces (quote (tex-math font-latex-math-face)))
      (setq-local company-math-disallow-unicode-symbols-in-faces nil)))

(setq doom-font (font-spec :family "Input Mono" :size 11.0)
      doom-variable-pitch-font (font-spec :family "Input Sans")
      doom-unicode-font (font-spec :name "DejaVu Sans Mono")
      doom-big-font (font-spec :family "Input Mono" :size 18.0)
      doom-theme 'doom-dracula)

;; refactoring support in haskell mode
(def-package! hlint-refactor
  :hook (haskell-mode . hlint-refactor-mode))

;; handy keybinding for deadgrep
(global-set-key (kbd "<f5>") #'deadgrep)

;; eshell aliases
(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

;; batteries-included magit setup:
(setq +magit-hub-features t
      magit-process-find-password-functions '(magit-process-password-auth-source)
      magithub-clone-default-directory "~/GitHub/")

;; (after! magit
  ;; Add gpg-sign to rebasing by default (stolen from Henrik)
  ;; (magit-define-popup-option 'magit-rebase-popup
    ;; ?S "Sign using gpg" "--gpg-sign=" #'magit-read-gpg-secret-key)

;; disable line numbers in text and derived modes.
(add-hook 'text-mode-hook #'doom|disable-line-numbers)

(after! markdown-mode
  ;; export markdown to beautiful html via pandoc
  (setq markdown-command "pandoc --filter pandoc-citeproc --standalone --css=http://benjam.info/pan-am/styling.css -V lang=en -V highlighting-css= --mathjax --from=markdown+smart --to=html5"
        ;; enable math highlighting
        markdown-enable-math t)
  ;; make markdown-mode less visually distracting:
  (add-hook! markdown-mode '(visual-line-mode turn-on-olivetti-mode)))

;; active dante-mode snippets in dante-mode (since it's a minor mode)
(add-hook 'dante-mode-hook
          #'(lambda ()
              (yas-activate-extra-mode 'dante-mode)))

;; counsel-linux-app looks in the right place for applications
;; (setq counsel-linux-apps-directories '("/var/run/current-system/sw/share/applications"))

;; avoid incompatibilities between tramp and zsh
;; (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
