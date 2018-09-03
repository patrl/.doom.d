;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :feature
       eval
       (evil +everywhere)
       file-templates
       (lookup +devdocs)
       snippets
       spellcheck
       (syntax-checker +childframe)
       workspaces

       :completion
       (company +auto +tng +childframe)
       (helm +childrame +fuzzy)
       ;; (ivy +childframe +fuzzy)

       :ui
       doom
       doom-dashboard
       doom-quit
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
       parinfer
       ;; rotate-text

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
       sh                ; she sells (ba|z)sh shells on the C xor
       web               ; the tubes
       ;; my langs:
       coq
       idris
       agda

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
      ;(email +gmail)    ; emacs as an email client
      ;irc               ; how neckbeards socialize
      ;(rss +org)        ; emacs as an RSS reader
      ;twitter           ; twitter client https://twitter.com/vnought
      ;(write            ; emacs as a word processor (latex + org + markdown)
      ; +wordnut         ; wordnet (wn) search
      ; +langtool)       ; a proofreader (grammar/style check) for Emacs

       :collab
      ;floobits          ; peer programming for a price
      ;impatient-mode    ; show off code over HTTP

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;literate

       ;; The default module set reasonable defaults for Emacs. It also provides
       ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
       ;; and additional ex commands for evil-mode. Use it as a reference for
       ;; your own modules.
       (default +bindings +snippets +evil-commands))

