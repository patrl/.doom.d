;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:leader
   (:desc "open" :prefix "o"
     :desc "APP: deft" :n "D" #'deft)

   (:desc "project" :prefix "p"
     :desc "Make project" :n "m" #'+make/run
     :desc "Search in project" :n "s" #'counsel-projectile-rg)

   (:desc "notes" :prefix "n"
     :desc "Search bibliography" :n "b" #'ivy-bibtex)
   ))

(after! haskell-mode
  (map! :map haskell-mode-map
        :localleader
        :desc "hlint refactor" :n "A" #'hlint-refactor-refactor-at-point))

