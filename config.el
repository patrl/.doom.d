;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;
;; general ;;
;;;;;;;;;;;;;

(setq doom-font (font-spec :family "IBM Plex Mono" :size 11.0)
      ;; doom-font (font-spec :family "Input Mono" :size 11.0)
      doom-variable-pitch-font (font-spec :family "iA Writer Duospace")
      ;; doom-variable-pitch-font (font-spec :family "Input Sans")
      doom-unicode-font (font-spec :name "DejaVu Sans Mono")
      doom-big-font (font-spec :family "IBM Plex Mono" :size 18.0)
      doom-theme 'doom-dracula)

(load! "+bindings.el") ;; load my custom bindings

(setq user-full-name "Patrick D. Elliott"
      user-mail-address "patrick.d.elliott@gmail.com")

(def-package! agda-input) ;; enable the agda input method globally. Depends on the agda module.

(setq +write-line-spacing 0.1)

;; counsel-linux-app looks in the right place for applications
(setq counsel-linux-apps-directories '("/var/run/current-system/sw/share/applications"))

(set-popup-rule! "\*compilation\*" :ttl nil)

;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;

(def-package! org-cliplink
  :commands org-cliplink)

;; org tweaks
(setq org-directory (expand-file-name "~/Sync/org/")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-highlight-latex-and-related '(latex)
      org-bullets-bullet-list '("#"))

;; TODO remove once my PR is accepted: https://github.com/hlissner/doom-emacs/pull/944
(def-package! org-brain
  :init
  (setq org-brain-path "/home/patrl/Sync/org/brain")
  (add-to-list 'evil-motion-state-modes 'org-brain-visualize-mode)
  ;; (with-eval-after-load 'evil
  ;;   (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (add-hook 'org-brain-visualize-mode-hook 'visual-line-mode)
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'files)
  (setq org-brain-title-max-length 24)
  ;; my additions
  (set-popup-rule! "*org-brain*" :ignore t))

;; deft tweaks for brain compatibility
;; TODO modify the summary rule for brain
(after! deft
  ;; (setq deft-directory "~/Sync/deft")
  (setq deft-directory org-brain-path
        ;; deft-recursive t
        deft-use-filename-as-title t
        deft-extensions '("org")))

;;;;;;;;;
;; nix ;;
;;;;;;;;;

;; nix tweaks
(after! nix-mode
  ;; use experiment nix indent function
  (setq nix-indent-function 'nix-indent-line))

;;;;;;;;;
;; tex ;;
;;;;;;;;;

(setq bibtex-completion-library-path "~/Sync/library/" ;; path to my pdf library
      bibtex-completion-pdf-symbol "" ;; custom icon to indicate that a pdf is available
      +latex-bibtex-file "~/GitHub/bibliography/elliott_mybib.bib"
      ivy-bibtex-default-action 'ivy-bibtex-open-pdf
      +latex-viewers `(zathura pdf-tools))

(after! tex
  (setq-default TeX-engine 'xetex)) ;; set the default engine to xetex

(setq +latex-enable-unicode-math t) ;; enable unicode-math completion:

;; ensures that unicode symbol completion only happens in math-mode
(after! latex
  (add-hook! 'LaTeX-mode-hook
    (setq-local company-math-allow-unicode-symbols-in-faces (quote (tex-math font-latex-math-face)))
    (setq-local company-math-disallow-unicode-symbols-in-faces nil)))

;;;;;;;;;;;;;
;; haskell ;;
;;;;;;;;;;;;;

;; refactoring support in haskell mode
;; (def-package! hlint-refactor
;;  :hook (haskell-mode . hlint-refactor-mode))

;; handy keybinding for deadgrep
(global-set-key (kbd "<f5>") #'deadgrep)

;; active dante-mode snippets in dante-mode (since it's a minor mode)
(add-hook 'dante-mode-hook
          #'(lambda ()
              (yas-activate-extra-mode 'dante-mode)))

(setq dante-methods '(styx impure-nix nix new-build nix-ghci stack mafia bare-cabal bare-ghci))

;;;;;;;;;;;;
;; eshell ;;
;;;;;;;;;;;;

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

;;;;;;;;;
;; git ;;
;;;;;;;;;

;; batteries-included magit setup:
(setq +magit-hub-features t
      magit-process-find-password-functions '(magit-process-password-auth-source)
      magithub-clone-default-directory "~/GitHub/")

;;;;;;;;;;;;;;
;; markdown ;;
;;;;;;;;;;;;;;

(after! markdown-mode
  ;; export markdown to beautiful html via pandoc
  (setq markdown-command "pandoc --filter pandoc-citeproc --standalone --css=http://benjam.info/pan-am/styling.css -V lang=en -V highlighting-css= --mathjax --from=markdown+smart --to=html5"
        ;; enable math highlighting
        markdown-enable-math t))

;;;;;;;;;;;;;;;
;; debugging ;;
;;;;;;;;;;;;;;;

;; for auth source debugging
;; (setq auth-source-do-cache nil
;; auth-source-debug t)

;; avoid incompatibilities between tramp and zsh
;; (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
