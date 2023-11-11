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
 '(lock-file-name-transforms '((".*" "~/.emacs.d/lockfiles/\\1" t)))
 '(neo-theme 'icons)
 '(package-selected-packages
   '(writegood-mode tex latex-preview-pane multiple-cursors flyspell-correct-ivy flyspell-correct ox-beamer auctex ox-reveal expand-region hungry-delete beacon company-mode modern-cpp-font-lock highlight-indent-guides ggtags undo-tree pdf-continuous-scroll-mode quelpa pdf-tools flycheck-pos-tip diff-hl doom-modeline smart-mode-line jedi yasnippet-snippets neotree amx color-theme auto-complete zenburn-theme which-key use-package try org-bullets doom-themes counsel ace-window))
 '(safe-local-variable-values
   '((flycheck-gcc-language-standard . "c++2a")
     (flycheck-gcc-language-standard . c++2a)
     (flycheck-gcc-language-standard . c++20)))
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
