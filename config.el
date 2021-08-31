;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;
;; general ;;
;;;;;;;;;;;;;

(setq user-full-name "Patrick D. Elliott"
      user-mail-address "patrick.d.elliott@gmail.com")

(setq delete-by-moving-to-trash t) ;; use trash-cli rather than rm when deleting files.

(add-load-path! "lisp") ;; used to load my own custom lisp files (currently just agda input)
(require 'agda-input) ;; loads agda-input, which is useful in places other than just agda-mode

(set-popup-rule! "\*compilation\*" :ttl nil) ;; means that compilation processes aren't killed after the associated buffer is closed. Useful for file watching.

(setq +notes-dir (expand-file-name "~/notes")
      +bib-file (expand-file-name "~/repos/bibliography/master.bib")
      +pdf-lib (expand-file-name "~/Dropbox (MIT)/library"))

;;;;;;;;;;;
;; NixOS ;;
;;;;;;;;;;;

;; (setq counsel-linux-apps-directories '("/var/run/current-system/sw/share/applications")) ;; FIXME This isn't actually ideal, since I'm installing almost everything via home-manager. I'm also not using ivy anymore.

;;;;;;;;;;;;;;;;
;; appearance ;;
;;;;;;;;;;;;;;;;

(setq display-line-numbers-type nil) ;; line numbers are pretty slow. This also improves performance.

;; (setq doom-font (font-spec :family "BlexMono Nerd Font" :size 11.0)
;;       doom-variable-pitch-font (font-spec :family "iA Writer Duospace" :size 10.0)
;;       doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 11.0))

(setq doom-font (font-spec :family "Operator Mono Book" :size 11.0)
      doom-variable-pitch-font (font-spec :family "iA Writer Duospace" :size 10.0)
      doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 11.0))

(setq doom-theme 'doom-dracula)

(load! "+bindings.el") ;; load my custom bindings

(setq +zen-text-scale 1) ;; correctly sets the text scale in zen mode.

;;;;;;;;;;;;
;; direnv ;;
;;;;;;;;;;;;

;; (add-hook 'before-hack-local-variables-hook #'direnv-update-environment) # TODO I can't remember why I needed this.

;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;

;; org-journal
;; (setq org-journal-file-format "%Y%m%d.org") # I'm using org dailies now instead of org journal. Convert org journal entries to roam daily and move there.

;; general org-mode tweaks
(after! org
  (add-hook! org-mode '(visual-line-mode writeroom-mode)))

(setq org-directory (expand-file-name "~/Dropbox (MIT)/org/")
      org-archive-location (concat org-directory "archive/%s::")
      org-ellipsis " ▼ "
      org-agenda-files (list org-directory +notes-dir)
      org-superstar-headline-bullets-list '("#")
      org-highlight-latex-and-related '(latex) ;; highlight latex fragments
      )

;; deft tweaks
;; TODO think about removing deft.
(setq deft-directory +notes-dir)

;; org-noter tweaks TODO fix org-noter
(setq org-noter-notes-window-location 'other-frame
        org-noter-always-create-frame nil
        org-noter-hide-other nil
        org-noter-notes-search-path (list +notes-dir)
        )

;;;;;;;;;;;;;;
;; org-roam ;;
;;;;;;;;;;;;;;

(setq org-roam-directory +notes-dir)

;; need this for org-roam-ui
(use-package! websocket
    :after org-roam)

;; org-roam-ui currently isn't on melpa
(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
    ; :hook (after-init . org-roam-ui-mode)
    :config
    (setq  rg-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(after! org
;; Needs Emacs to support svg display
(setq org-preview-latex-default-process 'xdvsvgm)

(add-to-list 'org-preview-latex-process-alist
               '(xdvsvgm :programs
                            ("xelatex" "dvisvgm")
                            :description "xdv > svg"
                            :message "you need to install the programs: xelatex and dvisvgm."
                            :image-input-type "xdv"
                            :image-output-type "svg"
                            :image-size-adjust (0.5 . 0.5)
                            :latex-compiler ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
                            :image-converter ("dvisvgm %f -n -b min -c %S -o %O"))
               )
(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))
(setf org-latex-default-packages-alist
      (remove '("T1" "fontenc" t ("pdflatex")) org-latex-default-packages-alist))
(setf org-latex-default-packages-alist
      (remove '("AUTO" "inputenc" t ("pdflatex")) org-latex-default-packages-alist))
(setf org-latex-default-packages-alist
      (remove '("" "amssymb" t) org-latex-default-packages-alist))
(add-to-list 'org-latex-packages-alist '("" "unicode-math"))
(add-to-list 'org-latex-packages-alist '("" "libertine"))
(add-to-list 'org-latex-packages-alist '("" "forest")) ;; FIXME this currently doesn't seem to be working.
)



;;;;;;;;;;;;;
;; org-ref ;;
;;;;;;;;;;;;;

(setq reftex-default-bibliography '(+bib-file))

(use-package! org-ref
  :after org
  :config
  (setq org-ref-bibliography-notes (concat +notes-dir "bibnotes.org")
        org-ref-default-bibliography (list +bib-file)
        org-ref-pdf-directory +pdf-lib))

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

(setq-hook! 'TeX-mode-hook +spellcheck-immediately nil) ;; stop doom from immediately running a spell check on every tex mode file

(setq! bibtex-completion-bibliography '("~/repos/bibliography/master.bib"))

(setq! bibtex-completion-library-path "~/Dropbox (MIT)/library/")

(setq! bibtex-completion-pdf-open-function  (lambda (fpath) (call-process "zathura" nil 0 nil fpath)))

(setq +latex-viewers '(zathura))

(after! tex
  (setq-default TeX-engine 'xetex)) ;; set the default engine to xetex

(setq +latex-enable-unicode-math t) ;; enable unicode-math completion:

;; ensures that unicode symbol completion only happens in math-mode
(after! latex
  (add-hook! 'LaTeX-mode-hook
    (setq-local company-math-allow-unicode-symbols-in-faces (quote (tex-math font-latex-math-face)))
    (setq-local company-math-disallow-unicode-symbols-in-faces nil)))

;;;;;;;;;;;;;;;;
;; purescript ;;
;;;;;;;;;;;;;;;;

(setq psc-ide-use-npm-bin t) ;; TODO can't remember why this is important

;;;;;;;;;;;;;
;; haskell ;;
;;;;;;;;;;;;;

(after! lsp-haskell
  (setq lsp-haskell-server-path "haskell-language-server"
        lsp-haskell-formatting-provider "brittany"))

;; get haskell-language-server working with lhs files
(add-hook! haskell-literate-mode #'lsp!)

;; Comment/uncomment this line to see interactions between lsp client/server.
(setq lsp-log-io t)

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
      magithub-clone-default-directory "~/repos/")

;;;;;;;;;;;;;;
;; markdown ;;
;;;;;;;;;;;;;;

(use-package pandoc-mode
  :hook (markdown-mode . pandoc-mode))

(after! markdown-mode
  (add-hook! markdown-mode '(visual-line-mode writeroom-mode))
  ;; export markdown to beautiful html via pandoc
  (setq markdown-command "pandoc --citeproc --standalone --css=http://benjam.info/pan-am/styling.css -V lang=en -V highlighting-css= --mathjax --from=markdown+smart --to=html5"
        ;; enable math highlighting
        markdown-enable-math t))

;;;;;;;;;;;
;; pico8 ;;
;;;;;;;;;;;

(use-package pico8-mode
  :mode "\\.p8\\'")

;;;;;;;;;;;;;;;
;; debugging ;;
;;;;;;;;;;;;;;;

;; avoid incompatibilities between tramp and zsh
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; for tramp debugging
(setq tramp-verbose 10)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" default))
 '(default-input-method "Agda")
 '(org-agenda-files
   '("~/notes/monadic-dynamic-semantics.org" "/home/patrl/Dropbox (MIT)/org/clothing.org" "/home/patrl/Dropbox (MIT)/org/elfeed.org" "/home/patrl/Dropbox (MIT)/org/fitness.org" "/home/patrl/Dropbox (MIT)/org/notes.org" "/home/patrl/Dropbox (MIT)/org/pillars.org" "/home/patrl/Dropbox (MIT)/org/projects.org" "/home/patrl/Dropbox (MIT)/org/todo.org"))
 '(safe-local-variable-values '((haskell-process-type quote cabal-repl))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
