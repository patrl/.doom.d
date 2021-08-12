;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company +childframe)
       (vertico +icons)

       :checkers
       (syntax +childframe)
       spell

       :ui
       deft
       doom
       doom-dashboard
       ;; doom-quit
       ;; (emoji +unicode)
       hl-todo
       (modeline +light)
       ;; nav-flash
       ophints
       (popup +all +defaults)
       ;; vi-tilde-fringe
       ;; window-select
       vc-gutter
       workspaces
       ;; treemacs
       zen

       :editor
       (evil +everywhere)
       ;; file-templates
       fold
       format
       multiple-cursors
       rotate-text
       snippets

       :emacs
       (dired +ranger +icons)
       electric
       (ibuffer +icons)
       undo
       vc

       :term
       eshell

       :tools
       biblio
       direnv
       (eval +overlay)
       gist
       lookup
       lsp
       magit
       make
       (pass +auth)
       pdf

       :lang
       common-lisp       ; if you've seen one lisp, you've seen them all
       data              ; config/data formats
       dhall
       emacs-lisp        ; drown in parentheses
       javascript
       (haskell +lsp)  ; a language that's lazier than I am
       ;; (haskell +dante)  ; a language that's lazier than I am
       (latex +latexmk +pdf-tools +unicode-math +ref)
       (markdown +pandoc)
       nix               ; I hereby declare "nix geht mehr!"
       (org +pandoc +roam2 +pomodoro +present +journal +noter)
       purescript
       racket
       rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (sh +fish)
       web               ; the tubes
       (lua +fennel)
       ;; my langs:
       coq
       idris
       (agda +local)
       yaml

       :app
       mu4e
       (rss +org)

       :config
       (default +bindings +snippets))
