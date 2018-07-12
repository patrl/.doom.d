;;; lang/haskell/config.el -*- lexical-binding: t; -*-

(def-package! dante
  :hook (haskell-mode . dante-mode)
  :config
  (when (featurep! :feature syntax-checker)
    (add-hook! 'dante-mode-hook
      (flycheck-add-next-checker 'haskell-dante '(warning . haskell-hlint)))))

(when (featurep! :emacs electric)
  (add-hook 'haskell-mode-hook 'electric-indent-mode))

;; Useful when using CamelCase with variable and function names.
(add-hook 'haskell-mode-hook 'subword-mode)

(add-hook 'haskell-mode-hook 'haskell-collapse-mode)

;; Automatically inserts module boilerplate.
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

;; Adds support for interactive haskell mode
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))

(def-package! hindent
  :hook (haskell-mode . hindent-mode))

(def-package! hlint-refactor
  :hook (haskell-mode . hlint-refactor-mode))

(after! haskell-mode
  (set-repl-handler! 'haskell-mode #'haskell-interactive-bring)
  (set-repl-handler! 'haskell-cabal-mode #'haskell-interactive-bring)
  (set-repl-handler! 'literate-haskell-mode #'haskell-interactive-bring)
  ;; (set-eval-handler! 'haskell-mode #'haskell-process-cabal-build)
  (add-to-list 'completion-ignored-extensions ".hi"))
