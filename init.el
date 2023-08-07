(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))


;; load myinit org file
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(custom-safe-themes
   '("288482f5c627c1fe5a1d26fcc17ec6ca8837f36bf940db809895bf3f8e2e4edd" default))
 '(neo-theme 'icons)
 '(package-selected-packages
   '(diff-hl doom-modeline smart-mode-line jedi yasnippet-snippets neotree amx color-theme auto-complete zenburn-theme which-key use-package try org-bullets doom-themes counsel ace-window))
 '(warning-suppress-types
   '((color-theme)
     (color-theme)
     (color-theme)
     (color-theme)
     (color-theme)
     (color-theme)
     (color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
