;; configuration for rust-mode

(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook 'flycheck-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
  (add-hook 'rust-mode-hook 'electric-operator-mode)
  (add-hook 'rust-mode-hook
	    (lambda () (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

  (use-package cargo
    :diminish cargo-mode
    :config (add-hook 'rust-mode-hook 'cargo-minor-mode))

  (use-package racer
    :diminish racer-mode
    :init
    ;; set the RUST_SRC_PATH to point to the rust source directory
    (setenv "RUST_SRC_PATH" "/Users/csraghunandan/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
    :config
    (defun my-racer-mode-hook ()
      (set (make-local-variable 'company-backends)
           '((company-capf company-dabbrev-code company-yasnippet company-files))))
    (add-hook 'racer-mode-hook 'my-racer-mode-hook)
    (add-hook 'racer-mode-hook #'company-mode)
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)))

(provide 'setup-rust)
