;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Patrick D. Elliott"
      user-mail-address "patrick.d.elliott@gmail.com")

(load! "+bindings.el")

(setq magit-process-find-password-functions '(magit-process-password-auth-source))

(setq org-directory (expand-file-name "~/Dropbox/org/")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-bullets-bullet-list '("#"))

(after! deft
  (setq deft-directory "~/Dropbox/deft"
        deft-extensions '("md" "org")
        deft-default-extension "org"
        deft-use-filter-string-for-filename t
        deft-use-filename-as-title nil
        deft-org-mode-title-prefix t
        deft-file-naming-rules '((noslash . "")
                                 (nospace . "")
                                 (case-fn . capitalize))))

(after! tex
  (setq-default TeX-engine 'xetex))

(setq markdown-command "pandoc --filter pandoc-citeproc --standalone --css=http://benjam.info/pan-am/styling.css -V lang=en -V highlighting-css= --mathjax --from=markdown+smart --to=html5"
      markdown-enable-math t)

(setq bibtex-completion-library-path "~/Dropbox/Library/"
      +latex-bibtex-file "~/GitHub/bibliography/elliott_mybib.bib"
      ivy-bibtex-default-action 'ivy-bibtex-open-pdf)

(setq doom-font (font-spec :family "Input Mono" :size 11.0)
      doom-variable-pitch-font (font-spec :family "Input Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-big-font (font-spec :family "Input Mono" :size 18.0)
      doom-theme 'doom-one-light)

(def-package! hlint-refactor
  :hook (haskell-mode . hlint-refactor-mode))

(setq org-highlight-latex-and-related '(latex))

(global-set-key (kbd "<f5>") #'deadgrep)

;; emacs/eshell
(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg"  "rg --color=always $*"))

(setq +magit-hub-features t
      magithub-clone-default-directory "~/GitHub/"
      magit-commit-arguments '("--gpg-sign=7CA109C3974AF5FA")
      magit-rebase-arguments '("--autostash" "--gpg-sign=7CA109C3974AF5FA")
      magit-pull-arguments '("--rebase" "--autostash" "--gpg-sign=7CA109C3974AF5FA"))


(after! magit
  ;; Add gpg-sign to rebasing by default
  (magit-define-popup-option 'magit-rebase-popup
    ?S "Sign using gpg" "--gpg-sign=" #'magit-read-gpg-secret-key))

;; disable line numbers in text and derived modes.
(add-hook 'text-mode-hook #'doom|disable-line-numbers)

;; tweaks for markdown mode.
(add-hook 'markdown-mode-hook #'doom|disable-line-numbers)
(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'markdown-mode-hook 'turn-on-olivetti-mode)

(add-hook 'dante-mode-hook
          #'(lambda ()
              (yas-activate-extra-mode 'dante-mode)))

;; `counsel-linux-app` looks in the right place for applications
(setq counsel-linux-apps-directories '("/var/run/current-system/sw/share/applications"))
