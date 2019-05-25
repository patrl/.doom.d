;; -*- no-byte-compile: t; -*-
;;; tools/org-noter/config.el -*- lexical-binding: t; -*-

(after! org-noter
  (map! :leader
        (:prefix "n"
          :desc "Org-noter-insert" :n "i" #'org-noter-insert-note)))
