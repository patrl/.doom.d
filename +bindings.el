;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map!
 (:leader
   (:desc "project" :prefix "p"
     :desc "Make project" :n "m" #'+make/run)

   (:desc "notes" :prefix "n"
     :desc "Search bibliography" :n "b" #'helm-bibtex
     :desc "deft" :n "d" #'deft)
   ))

(after! haskell-mode
  (map! :map haskell-mode-map
        :localleader
        :desc "hlint refactor" :n "A" #'hlint-refactor-refactor-at-point))

