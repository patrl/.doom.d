;;; lang/haskell/config.el -*- lexical-binding: t; -*-

(cond ((featurep! +intero) (load! "+intero"))
      ((featurep! +dante)  (load! "+dante")))

;;
;; Common plugins
;;

(add-hook 'haskell-mode-hook 'subword-mode)

(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

(def-package! hindent
  :hook (haskell-mode . hindent-mode))

(def-package! hlint-refactor
  :hook (haskell-mode . hlint-refactor-mode))

;; (def-package! lsp-haskell
  ;; :hook (haskell-mode . lsp-haskell-enable))

(after! haskell-mode
  (set-repl-handler! 'haskell-mode #'switch-to-haskell)
  (add-to-list 'completion-ignored-extensions ".hi"))
