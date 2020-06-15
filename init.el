;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       company
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
       fold
       format
       multiple-cursors
       rotate-text
       snippets

       :emacs
       (dired +ranger +icons)
       electric
       (ibuffer +icons)
       vc
       undo

       :term
       eshell

       :tools
       biblio
       direnv
       (eval +overlay)
       gist
       lookup
       lsp
       make
       magit
       (pass +auth)
       pdf
       ;; my tools:

       :lang
       common-lisp       ; if you've seen one lisp, you've seen them all
       clojure           ; java with a lisp
       data              ; config/data formats
       dhall
       emacs-lisp        ; drown in parentheses
       javascript
       (haskell +lsp +ghcide)  ; a language that's lazier than I am
       ;; (haskell +dante)  ; a language that's lazier than I am
       (latex +latexmk +pdf-tools +unicode-math)
       (markdown +pandoc)
       nix               ; I hereby declare "nix geht mehr!"
       (org +pandoc +roam +pomodoro +present +journal +noter)
       purescript
       (racket +pollen)
       rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (sh +fish)
       web               ; the tubes
       ;; my langs:
       coq
       idris
       (agda +local)
       scheme
       yaml

       :app
       mu4e
       (rss +org)

       :config
       (default +bindings +snippets))
