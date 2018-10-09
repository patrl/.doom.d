;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :feature
       eval
       (evil +everywhere)
       file-templates
       (lookup +docsets)
       snippets
       spellcheck
       (syntax-checker +childframe)
       workspaces

       :completion
       (company +tng +childframe)
       ;; (helm +childrame +fuzzy)
       (ivy +childframe +fuzzy)

       :ui
       doom
       doom-dashboard
       ;; doom-quit
       evil-goggles
       hl-todo
       modeline
       nav-flash
       treemacs
       (popup +all +defaults)
       vi-tilde-fringe
       window-select
       vc-gutter
       deft

       :editor
       format
       multiple-cursors
       ;; parinfer
       rotate-text

       :emacs
       dired
       ediff
       electric
       eshell
       hideshow
       imenu
       ;; term
       vc

       :tools
       ;; editorconfig
       ;; ein
       gist
       make
       magit
       (password-store +auth)
       pdf
       ;; my tools:
       org-noter
       ebib
       lsp

       :lang
       common-lisp       ; if you've seen one lisp, you've seen them all
       clojure           ; java with a lisp
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (haskell +dante)  ; a language that's lazier than I am
       (latex +latexmk +pdf-tools +unicode-math)
       (markdown +pandoc)
       nix               ; I hereby declare "nix geht mehr!"
       (org +attach +babel +capture +export +present)
       rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (sh +fish)
       web               ; the tubes
       ;; my langs:
       coq
       idris
       agda

       :app
       mu4e
       ;; (email +gmail)
       (rss +org)
       write

       :config
       (default +bindings +snippets +evil-commands))
