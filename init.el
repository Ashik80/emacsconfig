(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven-dark))
 '(package-selected-packages
   '(git-gutter-fringe git-gutter python-mode lsp-pyright auto-complete rust-mode flycheck company expand-region which-key exec-path-from-shell typescript-mode lsp-ui lsp-mode whick-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; General settings
(setq inhibit-startup-message t)

(set-face-attribute 'default nil
		    :family "Fira-Mono-Regular"
		    :height 130)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq make-backup-files nil)

(global-set-key (kbd "M-k") (lambda () (interactive) (kill-line 0)))
(global-display-line-numbers-mode)

;; Package related settings
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

(use-package expand-region
  :ensure t
  :config (global-set-key (kbd "C-;") 'er/expand-region) t)

(use-package auto-complete
  :ensure t
  :config (ac-config-default))

;; LSP setup
(use-package lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-c l")
  :config (lsp-enable-which-key-integration t)
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom (lsp-ui-sideline-show-diagnostics t)
  :commands lsp-ui-mode)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package typescript-mode
  :ensure t
  :hook (typescript-mode . lsp-deferred)
  :config (setq typescript-indent-level 2))

(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp-deferred)
  :config (setq rust-indent-level 4))

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :config (setq python-indent-level 4))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))

(use-package company
  :ensure t
  :after lsp-mode
  :bind (:map company-active-map
	      ("C-y" . company-complete-selection))
  :hook (lsp-mode . company-mode))

(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :ensure t)
