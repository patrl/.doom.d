;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:leader
   (:desc "project" :prefix "p"
     :desc "Make project" :n "m" #'+make/run)

   (:desc "notes" :prefix "n"
     :desc "Search bibliography" :n "b" #'ivy-bibtex
     :desc "deft" :n "d" #'deft
     :desc "brain" :n "D" #'+patrl/deft-brain)
   ))

(after! haskell-mode
  (map! :map haskell-mode-map
        :localleader
        :desc "hlint refactor" :n "A" #'hlint-refactor-refactor-at-point))
