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
