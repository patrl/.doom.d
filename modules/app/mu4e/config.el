;;; ~/.doom.d/app/mu4e/config.el -*- lexical-binding: t; -*-

(use-package! mu4e
  :commands (mu4e mu4e-compose-new)
  :init
  (provide 'html2text) ; disable obsolete package
  (setq mu4e-maildir "~/.mail" ;; where my mail is stored
        mu4e-attachment-dir "~/.mail/.attachments" ;; where my attachments are stored
        mu4e-user-mail-address-list nil)
  :config
  (add-hook! 'mu4e-view-mode-hook
    (setq-local truncate-lines nil))
  ;; (add-hook! 'message-send-hook 'mml-secure-message-sign-pgpmime) ;; cryptographically sign sent messages
  (setq mu4e-get-mail-command "mbsync -a"
        mu4e-change-filenames-when-moving t
        mu4e-update-interval nil ;; don't update automatically
        mu4e-index-cleanup nil
        mu4e-sent-messages-behavior 'sent ;; delete sent messages
        mu4e-index-lazy-check t
        mu4e-hide-index-messages t
        mu4e-view-show-addresses t ;; show full addresses in view message, instead of just names
        mu4e-view-show-images t
        mu4e-view-image-max-width 800
        mu4e-compose-format-flowed t
        mu4e-compose-signature-auto-include t
        message-send-mail-function #'smtpmail-send-it ;; use emacs built-in smtpmail function to send mail
        smtpmail-stream-type 'starttls
        smtpmail-stream-type 'ssl
        smtpmail-debug-info t
        smtpmail-debug-verb t
        mu4e-context-policy 'pick-first
        mu4e-compose-context-policy 'ask-if-none
        mu4e-completing-read-function (cond ((featurep! :completion ivy) #'ivy-completing-read)
                                            ((featurep! :completion helm) #'completing-read)
                                            (t #'ido-completing-read))
        message-kill-buffer-on-exit t
        mu4e-confirm-quit nil
        )
  (setq mu4e-contexts
        `( ,(make-mu4e-context
             :name "personal - patrick.d.elliott@gmail.com"
             :match-func (lambda (msg)
                           (when msg
                             (mu4e-message-contact-field-matches msg
                                                                 :to "patrick.d.elliott@gmail.com")))
             :vars '(
                     (mu4e-refile-folder . "/personal/archive")
                     (mu4e-sent-messages-behavior . delete)
                     (mu4e-sent-folder . "/personal/sent")
                     (mu4e-trash-folder . "/personal/trash")
                     (mu4e-drafts-folder . "/personal/drafts")
                     (user-mail-address . "patrick.d.elliott@gmail.com")
                     (user-full-name . "Patrick Elliott")
                     (smtpmail-smtp-user . "patrick.d.elliott@gmail.com")
                     (smtpmail-default-smtp-server . "smtp.gmail.com")
                     (smtpmail-smtp-server . "smtp.gmail.com")
                     ;; (smtpmail-auth-credentials . (expand-file-name "~/.authinfo"))
                     (smtpmail-smtp-service . 587)
                     ;; (smtpmail-smtp-service . 465)
                     ;; my personal sig
                     (mu4e-compose-signature . (concat "Patrick D. Elliott\n"
                                                       "\"You know I always wanted to pretend to be an architect\"\n"
                                                       "\n"
                                                       "-- Sent via mu4e\n"))
                     (mu4e-maildir-shortcuts . (("/personal/archive" . ?a)
                                                ("/personal/sent" . ?s)
                                                ("/personal/trash" . ?t)
                                                ("/personal/drafts" . ?d)
                                                ("/personal/Inbox" . ?i)))
                     ))
           ,(make-mu4e-context
             :name "mit - pdell@mit.edu"
             :match-func (lambda (msg)
                           (when msg
                             (mu4e-message-contact-field-matches msg
                                                                 :to "pdell@mit.edu")))
             :vars `(
                     (mu4e-refile-folder . "/mit/archive")
                     (mu4e-sent-messages-behavior . sent)
                     (mu4e-sent-folder . "/mit/sent")
                     (mu4e-trash-folder . "/mit/trash")
                     (mu4e-drafts-folder . "/mit/drafts")
                     (user-mail-address . "pdell@mit.edu")
                     (user-full-name . "Patrick Elliott")
                     (smtpmail-default-smtp-server . "outgoing.mit.edu")
                     (smtpmail-smtp-user . "pdell")
                     (smtpmail-smtp-server . "outgoing.mit.edu")
                     (smtpmail-smtp-service . 465)
                     ;; my mit sig
                     (mu4e-compose-signature . (concat "Patrick D. Elliott\n"
                                                       "Postdoctoral Associate, Massachusetts Institute of Technology\n"
                                                       "\n"
                                                       "-- Sent via mu4e\n"))
                     (mu4e-maildir-shortcuts . (("/mit/archive" . ?a)
                                                ("/mit/sent" . ?s)
                                                ("/mit/trash" . ?t)
                                                ("/mit/drafts" . ?d)
                                                ("/mit/Inbox" . ?i)))
                     ))
           ))
  ;; (setq mu4e-context-policy 'pick-first)
  (setq mu4e-user-mail-address-list
        (mapcar (lambda (context)
                  (let ((vars (mu4e-context-vars context)))
                    (cdr (assq 'user-mail-address vars))))
                mu4e-contexts))

  (after! evil
    (dolist (mode '(mu4e-main-mode mu4e-view-mode mu4e-headers-mode
                                   mu4e-compose-mode mu4e~update-mail-mode))
      (evil-set-initial-state mode 'normal))))

(use-package! mu4e-maildirs-extension
  :after mu4e
  :config
  (mu4e-maildirs-extension)
  (setq mu4e-maildirs-extension-title nil
        ;; mu4e-maildirs-extension-ignored-regex "^*~*"
        mu4e-maildirs-extension-action-text "\t[g] Update mail and index\n"
        mu4e-maildirs-extension-maildir-expanded-prefix "-"
        mu4e-maildirs-extension-maildir-default-prefix "|"))

(use-package! org-mu4e
  :hook (mu4e-compose-mode . org-mu4e-compose-org-mode)
  :config
  (setq org-mu4e-link-query-in-headers-mode nil
        org-mu4e-convert-to-html t)

  ;; Only render to html once. If the first send fails for whatever reason,
  ;; org-mu4e would do so each time you try again.
  (add-hook! 'message-send-hook
    (setq-local org-mu4e-convert-to-html nil)))
