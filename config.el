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

(setq counsel-linux-apps-directories '("/var/run/current-system/sw/share/applications")) ;; FIXME This isn't actually ideal, since I'm installing almost everything via home-manager.

;;;;;;;;;;;;;;;;
;; appearance ;;
;;;;;;;;;;;;;;;;

(setq display-line-numbers-type nil) ;; line numbers are pretty slow. This also improves performance.

(setq doom-font (font-spec :family "BlexMono Nerd Font" :size 11.0)
      doom-variable-pitch-font (font-spec :family "iA Writer Duospace" :size 10.0)
      doom-unicode-font (font-spec :name "DejaVu Sans Mono"))

(when (display-graphic-p)
  (setq doom-theme 'doom-gruvbox) ;; uses doom-dracula theme in gui mode
  (setq doom-theme 'doom-one)) ;; uses doom-one them otherwise

(load! "+bindings.el") ;; load my custom bindings

(setq +zen-text-scale 1) ;; correctly sets the text scale in zen mode.

;;;;;;;;;;;;
;; direnv ;;
;;;;;;;;;;;;

(add-hook 'before-hack-local-variables-hook #'direnv-update-environment)

;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;

(setq org-journal-file-format "%Y%m%d.org")

;; general org-mode tweaks
(after! org
  (add-hook! org-mode '(visual-line-mode)))

(setq org-directory (expand-file-name "~/Dropbox (MIT)/org/")
      org-archive-location (concat org-directory "archive/%s::")
      org-ellipsis " ▼ "
      org-agenda-files (list org-directory)
      org-superstar-headline-bullets-list '("#")
      org-highlight-latex-and-related '(latex) ;; highlight latex fragments
      )

;; deft tweaks
(setq deft-directory +notes-dir)

;; org-noter tweaks
(setq org-noter-notes-window-location 'other-frame
        org-noter-always-create-frame nil
        org-noter-hide-other nil
        org-noter-notes-search-path +notes-dir)

;; org-roam tweaks
(setq org-roam-directory +notes-dir
      org-roam-completion-system 'ivy)

;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package! org-roam-protocol
  :after org-protocol)

(use-package! org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-label-truncate t
        org-roam-server-label-truncate-length 60
        org-roam-server-label-wrap-length 20))

'(org-preview-latex-process-alist ;; latex fragment preview with xelatex (allows unicode symbols)
  (quote
   ((dvipng :programs
            ("lualatex" "dvipng")
            :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
            (1.0 . 1.0)
            :latex-compiler
            ("lualatex -output-format dvi -interaction nonstopmode -output-directory %o %f")
            :image-converter
            ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
    (dvisvgm :programs
             ("latex" "dvisvgm")
             :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "xdv" :image-output-type "svg" :image-size-adjust
             (1.7 . 1.5)
             :latex-compiler
             ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
             :image-converter
             ("dvisvgm %f -n -b min -c %S -o %O"))
    (imagemagick :programs
                 ("latex" "convert")
                 :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                 (1.0 . 1.0)
                 :latex-compiler
                 ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
                 :image-converter
                 ("convert -density %D -trim -antialias %f -quality 100 %O")))))

;; https://emacs.stackexchange.com/questions/30341/how-do-i-customize-the-process-that-gets-triggered-in-org-preview-latex-fragment/33172#33172
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))


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

(setq bibtex-completion-bibliography +bib-file
      ivy-bibtex-default-action 'ivy-bibtex-open-pdf
      ;; bibtex-completion-pdf-open-function  (lambda (fpath) (call-process "zathura" nil 0 nil fpath))
      +latex-viewers '(zathura))

(setq bibtex-completion-library-path +pdf-lib ;; path to my pdf library
      bibtex-completion-notes-path +notes-dir
      bibtex-completion-pdf-field "file"
      bibtex-completion-pdf-symbol "") ;; custom icon to indicate that a pdf is available)

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

(setq psc-ide-use-npm-bin t)

;;;;;;;;;;;;;
;; haskell ;;
;;;;;;;;;;;;;

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

(after! markdown-mode
  ;; export markdown to beautiful html via pandoc
  (setq markdown-command "pandoc --filter pandoc-citeproc --standalone --css=http://benjam.info/pan-am/styling.css -V lang=en -V highlighting-css= --mathjax --from=markdown+smart --to=html5"
        ;; enable math highlighting
        markdown-enable-math t))


;;;;;;;;;;;;;;;
;; debugging ;;
;;;;;;;;;;;;;;;

;; avoid incompatibilities between tramp and zsh
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; for tramp debugging
(setq tramp-verbose 10)
