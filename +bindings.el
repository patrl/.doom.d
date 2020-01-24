;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;;; handy keybinding for deadgrep
(global-set-key (kbd "<f5>") #'deadgrep)

(map!
 ;; Easier window navigation
 :n "C-h"   #'evil-window-left
 :n "C-j"   #'evil-window-down
 :n "C-k"   #'evil-window-up
 :n "C-l"   #'evil-window-right

 (:after treemacs-evil
   (:map evil-treemacs-state-map
     "C-h" #'evil-window-left
     "C-l" #'evil-window-right))

 (:after org-brain
   (:map org-brain-visualize-mode-map
     ;; #'org-brain-rename-file
     ;; #'org-brain-switch-brain
     ;; #'org-brain-headline-to-file
     ;; #'org-brain-update-id-locations
     ;; #'org-brain-insert-relationships
     ;; #'org-brain-create-relationships-from-links

     :m "C-k" #'evil-window-up
     :m "C-j" #'evil-window-down
     :m "C-h" #'evil-window-left
     :m "C-l" #'evil-window-right
     :m  "-" (λ! ()
                 (org-brain-visualize-remove-grandparent)
                 (org-brain-visualize-remove-grandchild))
     :m  "=" (λ! ()
                 (org-brain-visualize-add-grandparent)
                 (org-brain-visualize-add-grandchild))
     (:desc "add" :prefix "a"
       :m  "p" #'org-brain-add-parent
       :m  "c" #'org-brain-add-child
       :m  "f" #'org-brain-add-friendship
       :m  "r" #'org-brain-add-resource
       )

     (:desc "set" :prefix "s"
       :m  "a" #'org-brain-visualize-attach
       :m  "T" #'org-brain-set-title
       :m  "t" #'org-brain-set-tags
       )

     :m "p" #'org-brain-visualize-paste-resource
     :m "R" (λ! (org-brain-stop-wandering) (revert-buffer))

     (:desc "remove" :prefix "r"
       :m  "p" #'org-brain-remove-paren
       :m  "c" #'org-brain-remove-child
       :m  "f" #'org-brain-remove-friendship
       )

     (:desc "do" :prefix "d"
       :m  "d" #'org-brain-delete-entry
       :m  "p" #'org-brain-pin
       :m  "a" #'org-brain-archive
       )

     :m  "N" #'org-brain-new-child

     (:desc "view" :prefix "z"
       :m  "m" #'org-brain-visualize-mind-map
       :m  "b" #'org-brain-visualize-back
       :m  "r" #'org-brain-visualize-random
       :m  "w" #'org-brain-visualize-wander
       )

     :m  "j" #'forward-button
     :m  "k" #'backward-button

     :m  "o" #'org-brain-goto-current

     :m  "v" #'org-brain-visualize

     :m  "q" #'org-brain-visualize-quit
     )
   )
 )

(map!
 (:leader
   (:desc "project" :prefix "p"
     :desc "Make project" :n "m" #'+make/run)

   (:desc "notes" :prefix "n"
     :desc "Search bibliography" :n "b" #'ivy-bibtex
     :desc "deft" :n "d" #'deft
     :desc "visualize brain" :n "m" #'org-brain-visualize)
   "f o" #'browse-org-directory
   ))

(after! haskell-mode
  (map! :map haskell-mode-map
        :localleader
        :desc "hlint refactor" :n "A" #'hlint-refactor-refactor-at-point))
