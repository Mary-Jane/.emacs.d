;; Time-stamp: <2016-12-08 17:55:50 csraghunandan>

;; ERC - the irc client for emacs
(use-package erc :defer t
  :config
  ;; don't show messages when a users quits or joins
  (setq erc-hide-list '("PART" "QUIT" "JOIN"))
  ;; defaults for ERC mode
  (setq erc-server "irc.freenode.net"
	erc-nick "Rag1212")
  (setq erc-fill-column 100)

  ;; to enable notifications for ERC via terminal-notifier
  (defvar erc-terminal-notifier-command nil "The path to terminal-notifier.")
  (setq erc-terminal-notifier-command (executable-find "terminal-notifier"))

  (defun erc-terminal-notifier-notify (title message)
    "Show a message with `terminal-notifier-command`."
    (start-process "terminal-notifier"
                   "*terminal-notifier*"
                   erc-terminal-notifier-command
                   "-title" title
                   "-message" message
                   "-activate" "org.gnu.Emacs"
                   "-sender" "org.gnu.Emacs"
                   "-reply"))

  (defun erc-terminal-notifier-text-matched (match-type nick message)
    "Show a notification, when user's nick is mentioned."
    (when (eq match-type 'current-nick)
      (unless (posix-string-match "^\\** *Users on #" message)
        (erc-terminal-notifier-notify
         (concat "ERC " (buffer-name (current-buffer)))
         (concat "\\<" (nth 0 (erc-parse-user nick)) "> " message)))))

  (if (eq system-type 'darwin)
      (add-hook 'erc-text-matched-hook 'erc-terminal-notifier-text-matched))

  ;; set directory to save erc log files
  (setq erc-log-channels-directory "~/.erc/logs/")

  ;; if log file exists, load it
  (setq erc-log-insert-log-on-open t))

(provide 'setup-erc)

;; erc
;; press `C-c C-p' to quit erc channel
;; press `C-c C-l' to save the erc chat to log
;; if there are any logs, they will be restored automatically upon login