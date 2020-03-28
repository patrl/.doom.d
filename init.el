;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
       ;; (helm +childrame +fuzzy)
       (ivy +childframe +fuzzy)

       :checkers
       (syntax +childframe)
       spell

       :ui
       doom
       doom-dashboard
       doom-quit
       ophints
       hl-todo
       modeline
       nav-flash
       treemacs
       (popup +all +defaults)
       vi-tilde-fringe
       window-select
       vc-gutter
       workspaces
       deft
       zen

       :editor
       (evil +everywhere)
       file-templates
       fold
       format
       multiple-cursors
       rotate-text
       snippets

       :emacs
       (dired +ranger)
       electric
       vc

       :term
       eshell

       :tools
       direnv
       eval
       gist
       lookup
       lsp
       make
       magit
       (pass +auth)
       pdf
       ;; my tools:
       org-noter
       ebib

       :lang
       common-lisp       ; if you've seen one lisp, you've seen them all
       clojure           ; java with a lisp
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       javascript
       ;; (haskell +lsp)  ; a language that's lazier than I am
       (haskell +dante)  ; a language that's lazier than I am
       (latex +latexmk +pdf-tools +unicode-math)
       (markdown +pandoc)
       nix               ; I hereby declare "nix geht mehr!"
       (org +jupyter +pandoc +beamer)
       purescript
       racket
       rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (sh +fish)
       web               ; the tubes
       ;; my langs:
       coq
       idris
       agda
       scheme

       :app
       mu4e
       ;; (email +gmail)
       (rss +org)

       :config
       (default +bindings +snippets))
