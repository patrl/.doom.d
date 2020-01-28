;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;
;; general ;;
;;;;;;;;;;;;;

(setq user-full-name "Patrick D. Elliott"
      user-mail-address "patrick.d.elliott@gmail.com")

(use-package! agda-input) ;; enable the agda input method globally. Depends on the agda module.

;; counsel-linux-app looks in the right place for applications
(setq counsel-linux-apps-directories '("/var/run/current-system/sw/share/applications"))

(set-popup-rule! "\*compilation\*" :ttl nil)

;;;;;;;;;;;;;;;;
;; appearance ;;
;;;;;;;;;;;;;;;;

(setq display-line-numbers-type nil) ;; line numbers are pretty slow. This also improves performance.

(setq doom-font (font-spec :family "BlexMono Nerd Font" :size 11.0)
      ;; doom-font (font-spec :family "Input Mono" :size 11.0)
      doom-variable-pitch-font (font-spec :family "iA Writer Duospace" :size 11.0) ;; this works great
      ;; doom-variable-pitch-font (font-spec :family "Input Sans")
      doom-unicode-font (font-spec :name "DejaVu Sans Mono")
      ;; doom-big-font (font-spec :family "IBM Plex Mono" :size 11.0)
      )

(when (display-graphic-p)
  (setq doom-theme 'doom-dracula)
  (setq doom-theme 'doom-one))

(load! "+bindings.el") ;; load my custom bindings

;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;

(after! org
  (add-hook! org-mode '(visual-line-mode)))

;; org tweaks
(setq org-directory (expand-file-name "~/Dropbox (MIT)/org/")
      org-archive-location (concat org-directory "archive/%s::")
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-highlight-latex-and-related '(latex) ;; highlight latex fragments
      org-bullets-bullet-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷"))

;; TODO remove once my PR is accepted: https://github.com/hlissner/doom-emacs/pull/944
;; (use-package! org-brain
;;   :init
;;   (setq org-brain-path (concat org-directory "brain"))
;;   (add-to-list 'evil-motion-state-modes 'org-brain-visualize-mode)
;;   ;; (with-eval-after-load 'evil
;;   ;;   (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
;;   :config
;;   (add-hook 'org-brain-visualize-mode-hook 'visual-line-mode)
;;   (push '("b" "Brain" plain (function org-brain-goto-end)
;;           "* %i%?" :empty-lines 1)
;;         org-capture-templates)
;;   (setq org-brain-visualize-default-choices 'root)
;;   (setq org-brain-title-max-length 24)
;;   ;; my additions
;;   (set-popup-rule! "*org-brain*" :ignore t))

(setq org-brain-path (concat org-directory "brain"))

(setq org-publish-project-alist '(("org-brain"
                                   ;; dir for source files in org format
                                   :base-directory "~/Dropbox (MIT)/org/brain"
                                   :base-extension "org"
                                   :exclude "maths.org\\|coding.org\\|index.org"
                                   ;; html dir
                                   :publishing-directory "~/keybase/private/patrl,kbpbot/wiki"
                                   :publishing-function org-html-publish-to-html
                                   :recursive t
                                   :auto-sitemap t
                                   :sitemap-title "Brain"
                                   :sitemap-filename "index"
                                   )))

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
(add-to-list 'org-latex-packages-alist '("" "unicode-math"))


(after! deft
  (setq deft-directory "~/Dropbox (MIT)/deft"
        deft-extensions '("org" "md" "tex")
        deft-use-filter-string-for-filename t
        deft-org-mode-title-prefix t))

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

(setq bibtex-completion-library-path "~/Dropbox (MIT)/library/" ;; path to my pdf library
      bibtex-completion-bibliography "~/repos/bibliography/elliott_mybib.bib"
      bibtex-completion-pdf-symbol "" ;; custom icon to indicate that a pdf is available
      +latex-bibtex-file "~/repos/bibliography/elliott_mybib.bib"
      ivy-bibtex-default-action 'ivy-bibtex-open-pdf
      ;; bibtex-completion-pdf-open-function  (lambda (fpath) (call-process "zathura" nil 0 nil fpath))
      +latex-viewers '(zathura))

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

;; active dante-mode snippets in dante-mode (since it's a minor mode)
(add-hook 'dante-mode-hook
          #'(lambda ()
              (yas-activate-extra-mode 'dante-mode)))

;; enable dante eldoc support
(setq dante-tap-type-time 0.5)

;; ensures that impure-nix is tried before nix.
(setq dante-methods '(new-build bare-ghci))

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


(use-package! pandoc-mode
  :hook markdown-mode
  :config
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings))

;;;;;;;;;;;;;;;
;; debugging ;;
;;;;;;;;;;;;;;;

;; avoid incompatibilities between tramp and zsh
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; for tramp debugging
(setq tramp-verbose 10)
