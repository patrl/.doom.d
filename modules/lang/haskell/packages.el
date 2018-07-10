;; -*- no-byte-compile: t; -*-
;;; lang/haskell/packages.el

(package! haskell-mode)

;;
(cond ((featurep! +dante)
       (package! dante))
      ((featurep! +intero)
       (package! intero)))

;; (package! lsp-haskell)

(package! hindent)

(package! hlint-refactor :recipe (:fetcher github :repo "mpickering/hlint-refactor-mode"))

