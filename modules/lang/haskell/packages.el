;; -*- no-byte-compile: t; -*-
;;; lang/haskell/packages.el

(package! haskell-mode)

(package! dante)

;; (package! lsp-haskell)

(package! hindent)

(package! hlint-refactor :recipe (:fetcher github :repo "mpickering/hlint-refactor-mode"))
