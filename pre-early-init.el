;;; pre-init.el --- Pre Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; Author: Kai Jenkins
;; URL: https://github.com/karj/minimal-emacs.d

;;; Commentary:
;; This file is loaded before `init.el'. Use it to set up variables or configurations that need to be
;; available early in the initialization process but after `early-init.el'.

;;; Code:
(when init-file-debug
  (setq debug-on-error t))

;;; Reducing clutter in ~/.emacs.d by redirecting files to ~/.emacs.d/var/
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
