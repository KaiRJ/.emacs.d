;; -*- lexical-binding: t; -*-

(setq use-package-always-ensure t)

(when init-file-debug
  (setq use-package-verbose t
        use-package-expand-minimally nil
        use-package-compute-statistics t))

(use-package emacs
  :ensure nil
  :hook
  ;; Clean up white space when file is saved
  (before-save-hook . whitespace-cleanup)
  :custom
  ;; Merge system's and Emacs' clipboard
  (select-enable-clipboard t)
  ;; Save current (system) clipboard before replacing
  (save-interprogram-paste-before-kill t)
  ;; C-n adds new line if reaches end of buffer
  (next-line-add-newlines t)
  ;; Delete highlighted text by typing
  (delete-selection-mode 1)
  ;; don't compact font caches during GC.
  (inhibit-compacting-font-caches t)
  :config
  ;; Font size
  (set-face-attribute 'default nil :height 140))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; Remap quary replace so its not on M-% which is screenshot on mac
(keymap-global-set "M-r" 'quary-repace)

;; Switch to new window on window split
(global-set-key "\C-x2"
                (lambda ()
                  (interactive)
                  (split-window-vertically)
                  (other-window 1)))

(global-set-key "\C-x3"
                (lambda ()
                  (interactive)
                  (split-window-horizontally)
                  (other-window 1)))

;; Bind comment-line to C-; instead of C-x C-;
(global-set-key (kbd "C-;") 'comment-line)

(defun kai/duplicate-line()
  "Duplicate the current line below."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(global-set-key (kbd "s-d") 'kai/duplicate-line)

(defun kai/compile-build ()
  "Compile using 'make build'."
  (interactive)
  (compile "make build"))

(defun kai/compile-clean ()
  "Clean using 'make clean'."
  (interactive)
  (compile "make clean"))

;; makefile keybindings
(global-set-key (kbd "<f5>") 'kai/compile-build)
(global-set-key (kbd "<f6>") 'kai/compile-clean)

(defun kai/kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'kai/kill-this-buffer)

(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))

(defun kai/comment-line-stay ()
  "Toggle comment on current line without moving point."
  (interactive)
  (let ((orig-pos (point)))
    (comment-line nil)  ;; nil = behave normally (toggle)
    (goto-char orig-pos)))

(global-set-key (kbd "C-;") 'kai/comment-line-stay)

(use-package all-the-icons)

(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config) ;; Enable flashing mode-line on errors
  (doom-themes-org-config))        ;; Corrects (and improves) org-mode's native fontification.

(use-package doom-modeline
  :init (doom-modeline-mode)
  :custom
  (doom-modeline-icon (display-graphic-p))
  (doom-modeline-mu4e t)
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-buffer-file-name-style 'file-name-with-project)
  (doom-modeline-position-column-line-format '("L%l"))
  (doom-modeline-checker-simple-format nil)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-vcs-max-length 12))

;; optional dependancy of emacs-dashboard
(use-package page-break-lines)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-items '((projects . 5)
                     (recents . 5)))
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-set-navigator t)
  (dashboard-startup-banner 'official))

(use-package try)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(setq projectile-project-search-path '("~/git/"))

(use-package helpful
  :commands (helpful-at-point
             helpful-callable
             helpful-command
             helpful-function
             helpful-key
             helpful-macro
             helpful-variable)
  :bind
  ([remap display-local-help] . helpful-at-point)
  ([remap describe-function] . helpful-callable)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-key] . helpful-key)
  ([remap describe-command] . helpful-command))

;; indent with tabs for better readability
(add-hook 'org-mode-hook #'org-indent-mode)
;; (setq org-indent-indentation-per-level 4)

;; When editing org-files with source-blocks, we want the source blocks to be themed as they would in their native mode.
(setq org-src-fontify-natively t
  org-src-tab-acts-natively t
  org-confirm-babel-evaluate nil)

;; Standard key bindings
;; (global-set-key (kbd "\C-c l") 'org-store-link)
(global-set-key (kbd "\C-c a") 'org-agenda)
(global-set-key (kbd "\C-c c") 'org-capture)
(global-set-key (kbd "\C-c b") 'org-iswitchb)

;;
(setq org-agenda-files (quote ("~/git/agenda/phd/simulations.org"
                               "~/git/agenda/phd/prominence.org"
                               "~/git/agenda/personal.org"
                               "~/git/agenda/emacs.org")))

;; Define the keywords for the agenda
(setq org-todo-keywords
      '((sequence "TODO(t)"    "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w)" "HOLD(h)" "|" "CANCELLED(c)")))

(setq org-log-done 'time)

;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %TIMESTAMP_IA")

;; Colour the keywords
(setq org-todo-keyword-faces
      (quote (("TODO"      :foreground "red"          :weight bold)
              ("NEXT"      :foreground "blue"         :weight bold)
              ("DONE"      :foreground "forest green" :weight bold)
              ("WAITING"   :foreground "orange"       :weight bold)
              ("HOLD"      :foreground "magenta"      :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

;; Org bullets makes things look pretty
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package counsel ;; installs ivy and swiper as dependancies
  :config (ivy-mode)

  :custom
  (ivy-use-virtual-buffers t)
  (ivy-display-style 'fancy)
  (ivy-wrap t)

  ;; should_ speed swiper up
  (swiper-use-visual-line nil)
  (swiper-use-visual-line-p (lambda (a) nil))

  ;; ignore certain files in find-file
  (counsel-find-file-ignore-regexp "\\(?:\\.DS_Store\\)")
  (ivy-extra-directories nil) ;; /. and /..

  :bind (("C-x b"   . ivy-switch-buffer)
         ("M-w"     . ivy-kill-ring-save)
         ("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("M-y"     . counsel-yank-pop)
         ("C-h f"   . counsel-describe-function)
         ("C-h v"   . counsel-describe-variable)
         ("C-h l"   . counsel-find-library)
         ("C-s"     . swiper)
         ;; (global-set-key (kbd "C-r") 'swiper) ;; using this for quary-replace
         ("s-s"     . counsel-ag)
         ("M-i"     . counsel-imenu)))

(use-package which-key
  :custom (which-key-idle-delay 0.5)
  :config (which-key-mode))

(use-package amx
  :custom
  (amx-backend 'auto)
  :config
  (amx-mode 1))

(use-package marginalia
  :after ivy
  :init (marginalia-mode)
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil)))

(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :config
  ;; (setq ibuffer-default-sorting-mode 'major-mode)
  (setq ibuffer-show-empty-filter-groups nil))

(use-package ibuffer-vc
  :after ibuffer)

(defun ibuffer-apply-filter-groups ()
  "Combine my saved ibuffer filter groups with those generated
     by `ibuffer-vc-generate-filter-groups-by-vc-root' taken from `https://github.com/reinh/dotemacs/blob/master/conf/init.org#ido'"
  (interactive)
  (setq ibuffer-filter-groups
        (append
         (ibuffer-vc-generate-filter-groups-by-vc-root)
         ibuffer-saved-filter-groups))
  (message "ibuffer-vc: groups set")
  (let ((ibuf (get-buffer "*Ibuffer*")))
    (when ibuf
      (with-current-buffer ibuf
        (pop-to-buffer ibuf)
        (ibuffer-update nil t)))))

;; Tell ibuffer to load the group automatically
(add-hook 'ibuffer-hook 'ibuffer-apply-filter-groups)

(use-package imenu-list
  :ensure t)

(global-set-key (kbd "s-i") #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-auto-resize t)

(setq imenu-list-after-jump-hook nil)
(add-hook 'imenu-list-after-jump-hook #'top)

;; for easy window switching between multiple windows
(use-package ace-window
  :init
  (progn
    ;; bind ace-window to M-o
    (global-set-key (kbd "M-o") 'ace-window)
    ;; set window lables to home row
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    (custom-set-faces
     '(aw-leading-char-face
   ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package avy
  :ensure t
  :bind
  ("M-s"     . avy-goto-word-1)
  ("M-g M-g" . 'avy-goto-line))

(use-package window
  :ensure nil
  :bind (("C-x 2" . vsplit-last-buffer)
         ("C-x 3" . hsplit-last-buffer)
         ;; Don't ask before killing a buffer.
         ([remap kill-buffer] . kill-this-buffer))
  :preface
  (defun hsplit-last-buffer ()
    "Focus to the last created horizontal window."
    (interactive)
    (split-window-horizontally)
    (other-window 1))

  (defun vsplit-last-buffer ()
    "Focus to the last created vertical window."
    (interactive)
    (split-window-vertically)
    (other-window 1)))

(use-package treemacs
  :config
  (progn
    (setq treemacs-hide-dot-git-directory          t
          treemacs-move-files-by-mouse-dragging    t
          treemacs-sorting                         'alphabetic-asc
          treemacs-width                           28)
    (treemacs-project-follow-mode t)
    (treemacs-resize-icons 24))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs)

(use-package treemacs-magit
  :after treemacs)

(use-package treemacs-all-the-icons
  :after treemacs all-the-icons
  :config (treemacs-load-theme "all-the-icons"))

(use-package ultra-scroll
:init
(setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
      scroll-margin 0)        ; important: scroll-margin>0 not yet supported
:config
(ultra-scroll-mode 1))

(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (global-set-key (kbd "s-<down>") 'drag-stuff-down)
  (global-set-key (kbd "s-<up>") 'drag-stuff-up)
  (global-set-key (kbd "s-<right>") 'drag-stuff-right)
  (global-set-key (kbd "s-<left>") 'drag-stuff-left))

(use-package yasnippet-snippets
  :after yasnippet
  :config (yasnippet-snippets-initialize))

(use-package yasnippet
  :delight yas-minor-mode "ﾃ遵"
  :config (yas-global-mode))

(use-package ivy-yasnippet :after yasnippet)

(use-package iedit
  :bind
  ("C-r" . iedit-mode)
  :config
  (define-key iedit-mode-keymap (kbd "C-;") nil)) ;; unbind as used for commend-line

(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :config
  (setq undo-tree-visualizer-diff t) ;; show difs
  (setq undo-tree-auto-save-history t) ;; save history to file
  (setq undo-tree-visualizer-timestamps t) ;; show timestamps

  ;; Create the undo history directory if it doesn't exist
  (let ((undo-history-dir (expand-file-name "undo-history" user-emacs-directory)))
    (unless (file-directory-p undo-history-dir)
  (make-directory undo-history-dir)))

  ;; Set the directory for undo history files
  (setq undo-tree-history-directory-alist
    `((".*" . ,(expand-file-name "undo-history" user-emacs-directory)))))

(use-package multiple-cursors
  :bind
  ;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  ;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package programming
  :ensure nil
  :hook
  (;; Add line numbers to progam modes
   (prog-mode . display-line-numbers-mode)
   ;; Line Wrappings
   (prog-mode . (lambda () (setq truncate-lines t))))
  :custom
  ;; Treat CamelCase as distinct words
  (global-subword-mode 1))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((prog-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-enable-folding nil)
  (lsp-enable-links nil)
  (lsp-enable-snippet nil)
  (lsp-keymap-prefix "C-c l")
  (lsp-prefer-capf t)                   ;; Use completion-at-point-functions
  (lsp-headerline-breadcrumb-enable t)) ;; Show breadcrumbs

  ;; Clangd is fast
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.500
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point))

(use-package consult-lsp
  :commands (consult-lsp-diagnostics consult-lsp-symbols))

(use-package lsp-treemacs
  :ensure t
  :after (lsp-mode treemacs)
  :bind
  ("C-c l l" . lsp-treemacs-errors-list) ; TODO move to hydra table
  :config
  (lsp-treemacs-sync-mode 1))

(use-package treesit-auto
  :disabled
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package flycheck
  :delight
  :hook (lsp-mode . flycheck-mode)
  :bind (:map flycheck-mode-map
              ("M-'" . flycheck-previous-error)
              ("M-\\" . flycheck-next-error))
  :custom (flycheck-display-errors-delay .3))

(use-package dap-mode
  :after lsp-mode
  :hook (dap-stopped . (lambda (arg) (call-interactively #'dap-hydra)))
  :config
  (dap-auto-configure-mode)  ;; Automatically configures dap-mode
  (require 'dap-cpptools)

  (dap-register-debug-template
   "cpptools::main"
   (list :type "cppdbg"
         :request "launch"
         :MIMode "lldb"
         :program "${workspaceFolder}/build/main"
         :cwd "${workspaceFolder}"))

  (dap-register-debug-template
   "cpptools::main-input"
   (list :name "cpptools::main-input"
         :type "cppdbg"
         :request "launch"
         :MIMode "lldb"
         :program "${workspaceFolder}/build/main"
         :cwd "${workspaceFolder}"
         :externalConsole t)))

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :custom
  (company-show-quick-access t)
  (company-idle-delay 0.2)               ;; Delay before suggestions popup
  (company-minimum-prefix-length 1)      ;; Show suggestions after 1 char
  (company-tooltip-align-annotations t)) ;; Align annotations (e.g., function signatures)

;; for visuals
(use-package company-box
  :after company
  :init (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  :hook (company-mode . company-box-mode))

(use-package magit)

(use-package git-gutter
  :ensure t
  :hook ((prog-mode . git-gutter-mode)
     (org-mode . git-gutter-mode))
  :config
  (setq git-gutter:update-interval 0.5)) ;; if too small causes lagging

;; makes it prettier
(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

;; Customize the git-gutter:modified face to use different colours
(set-face-foreground 'git-gutter-fr:modified "#2375B3")
;; (set-face-foreground 'git-gutter-fr:added    "blue")
;; (set-face-foreground 'git-gutter-fr:deleted  "white")

;; Define a hydra to choose the target server (nersc or deucalion)
(defhydra hydra-sync-git (:color blue)
  "
Sync to which server?
_n_ NERSC
_d_ Deucalion
_q_ Quit
"
  ("n" (run-sync-git-tracked-script "nersc"))
  ("d" (run-sync-git-tracked-script "deucalion"))
  ("q" nil "quit"))

;; Function to run the sync script with an argument
(defun run-sync-git-tracked-script (target)
  "Run the sync_git_tracked.sh script with the specified TARGET argument."
  (interactive "sTarget (nersc or deucalion): ") ;; Allow the hydra to pass this value
  (let ((default-directory (locate-dominating-file default-directory ".git")))
    (if default-directory
        (progn
          ;; Run the sync script with the argument based on the hydra choice
          (let ((script (concat "~/git/scripts/sync_git_tracked.sh")))
            (if (file-executable-p script)
                (call-process-shell-command (concat script " " target) nil "*scratch*")
              (message "Error: sync_git_tracked.sh not found or not executable."))))
      (message "Error: Not inside a Git repository!"))))

;; Bind the hydra to a keyboard shortcut
(global-set-key (kbd "C-c s") 'hydra-sync-git/body)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :disabled
  :ensure t
  :hook
  ( ;; (prog-mode . smartparens-strict-mode)
   (markdown-mode-hook . turn-on-smartparens-mode)) ;; can use strict-mode also
  :config
  ;; load default config
  (require 'smartparens-config)
  :bind
  ("C-M-a" . sp-beginning-of-sexp)
  ("C-M-e" . sp-end-of-sexp)
  ("C-<up>" . sp-up-sexp)
  ("C-<down>" . sp-down-sexp)
  ("M-<up>" . sp-backward-up-sexp)
  ("M-<down>" . sp-backward-down-sexp)
  ("M-[" . sp-backward-unwrap-sexp)
  ("M-]" . sp-unwrap-sexp))

(use-package aggressive-indent
  :custom
  (aggressive-indent-comments-too t))

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  ;; Use thin character style
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?|) ;; Unicode thin vertical bar
  (setq highlight-indent-guides-responsive 'top) ;; Active indent
  (setq highlight-indent-guides-auto-enabled t)

  ;; Show guides even on blank lines
  (setq highlight-indent-guides-show-leading-blank-lines t)

  ;; Customize colors to fit doom-one
  (set-face-foreground 'highlight-indent-guides-character-face "#3f444a")
  (set-face-foreground 'highlight-indent-guides-top-character-face "#875faf")
  (set-face-foreground 'highlight-indent-guides-stack-character-face "#5c5f77"))

;; (use-package highlight-indentation
;;   :hook ((prog-mode . highlight-indentation-mode)
;;          (prog-mode . highlight-indentation-current-column-mode))
;;    :custom
;;    (highlight-indentation-blank-lines t) ;; Enable highlighting of blank lines.
;;    :config
;;    ;; Customize the face for the indent guides
;;    (set-face-background 'highlight-indentation-face "#3f444a")
;;    (set-face-background 'highlight-indentation-current-column-face "#5f8787"))

;; make sure up to date
(require 'cc-mode)

;; set .h files to use c++ mode instead
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(use-package google-c-style
  :hook (((c-mode c++-mode) . google-set-c-style)
         (c-mode-common . google-make-newline-indent)))

(use-package cmake-mode
  :hook (cmake-mode . lsp-deferred)
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

;; for better sytax colours
(use-package cmake-font-lock
  :hook (cmake-mode . cmake-font-lock-activate))

;; use makefile-mode for MakeFiles
(add-to-list 'auto-mode-alist '("Makefile" . makefile-mode))

(use-package writing
  :ensure nil
  :hook
  ;; Line Wrappings
  (text-mode . turn-on-visual-line-mode))

(use-package flyspell
  :ensure nil
  :delight
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :config
  (define-key flyspell-mode-map (kbd "C-;") nil) ;; unbind as used for commend-line
  :custom
  ;; Add correction to abbreviation table.
  (flyspell-abbrev-p t)
  (flyspell-default-dictionary "en_GB")
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil))

;; recommended to speed up flycheck
;; (setq flyspell-issue-message-flag nil)

;; easy spell check
;; (global-set-key (kbd "<f8>") 'ispell-word)
;; (global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
;; (global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)

;; (defun flyspell-check-next-highlighted-word ()
;;   "Custom function to spell check next highlighted word"
;;   (interactive)
;;   (flyspell-goto-next-error)
;;   (ispell-word)
;;   )
;; (global-set-key (kbd "C-<f8>") 'flyspell-check-next-highlighted-word)
;; (global-set-key (kbd "M-<f8>") 'flyspell-check-previous-highlighted-word)

(use-package ispell
  ;; :custom
  ;; (ispell-hunspell-dict-paths-alist
  ;;  '(("en_US" "/usr/share/hunspell/en_US.aff")
  ;;    ("fr_BE" "/usr/share/hunspell/fr_BE.aff")))
  ;; Save words in the personal dictionary without asking.
  :custom
  (ispell-silently-savep t)
  :config
  (setenv "LANG" "en_GB")
  (cond ((executable-find "hunspell")
         (setq ispell-program-name "hunspell"))
        ((executable-find "aspell")
         (setq ispell-program-name "aspell")
         (setq ispell-extra-args '("--sug-mode=ultra"))))
  ;; Ignore file sections for spell checking.
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_align" . "#\\+end_align"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_align*" . "#\\+end_align*"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_equation" . "#\\+end_equation"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_equation*" . "#\\+end_equation*"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_example" . "#\\+end_example"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_labeling" . "#\\+end_labeling"))
  (add-to-list 'ispell-skip-region-alist '("#\\+begin_src" . "#\\+end_src"))
  (add-to-list 'ispell-skip-region-alist '("\\$" . "\\$"))
  (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
  (add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:")))

(use-package lsp-ltex
  :after lsp-mode
  :hook ((latex-mode) . (lambda ()
                          (require 'lsp-ltex)
                          (lsp)))
  :init
  (setq lsp-ltex-version "16.0.0"))

(use-package writegood-mode
  :ensure t)

(add-hook 'TeX-mode-hook 'writegood-mode)

(use-package tex
  :ensure auctex
  :hook
  (TeX-mode . display-line-numbers-mode)
  :preface
  (defun my/switch-to-help-window (&optional ARG REPARSE)
    "Switches to the *TeX Help* buffer after compilation."
    (other-window 1))
  :hook ((LaTeX-mode . reftex-mode)
         (LaTeX-mode . prettify-symbols-mode))
  :bind (:map TeX-mode-map
              ("C-c C-o" . TeX-recenter-output-buffer)
              ("C-c C-l" . TeX-next-error)
              ("M-[" . outline-previous-heading)
              ("M-]" . outline-next-heading))
  :custom
  (TeX-auto-save t)
  (TeX-byte-compile t)
  (TeX-clean-confirm nil)
  (TeX-master 'dwim)
  (TeX-parse-self t)
  (TeX-PDF-mode t)
  (TeX-source-correlate-mode t)
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  :config
  (advice-add 'TeX-next-error :after #'my/switch-to-help-window)
  (advice-add 'TeX-recenter-output-buffer :after #'my/switch-to-help-window)
  ;; the ":hook" doesn't work for this one... don't ask me why.
  (add-hook 'TeX-after-compilation-finished-functions 'TeX-revert-document-buffer))

(setq-default TeX-engine 'xetex)

(use-package lsp-latex
  :if (executable-find "texlab")
  ;; To properly load `lsp-latex', the `require' instruction is important.
  :hook (LaTeX-mode . (lambda ()
                        (require 'lsp-latex)
                        (lsp-deferred)))
  :custom (lsp-latex-build-on-save t))

(use-package reftex
  :ensure nil
  :custom
  (reftex-save-parse-info t)
  (reftex-use-multiple-selection-buffers t))

(use-package bibtex
  :ensure nil
  :preface
  (defun my/bibtex-fill-column ()
    "Ensure that each entry does not exceed 120 characters."
    (setq fill-column 120))
  :hook ((bibtex-mode . lsp-deferred)
         (bibtex-mode . my/bibtex-fill-column)))
