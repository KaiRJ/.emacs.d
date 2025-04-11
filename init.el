;;; Commentary:

;; Following lines build the configuration code out of the myinit.el file.

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 100 1024 1024))

(require 'package)
(package-initialize)

;; load myinit org file
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 10 1000 1000))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(lock-file-name-transforms '((".*" "~/.emacs.d/lockfiles/\\1" t)))
 '(package-selected-packages
   '(aggressive-indent amx auctex cmake-font-lock company-box consult-lsp counsel
                       dap-mode dashboard doom-modeline doom-themes drag-stuff
                       exec-path-from-shell expand-region flycheck
                       git-gutter-fringe highlight-indent-guides
                       highlight-indentation ibuffer-vc iedit imenu-list lsp-ui
                       move-text multiple-cursors org-bullets page-break-lines
                       rainbow-delimiters smartparens tree-sitter-langs
                       treemacs-all-the-icons treemacs-magit treemacs-projectile
                       try undo-tree use-package which-key writegood-mode
                       yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
