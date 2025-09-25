;;; post-init.el --- Post Init -*- no-byte-compile: t; lexical-binding: t; -*-

;; Author: Kai Jenkins
;; URL: https://github.com/karj/minimal-emacs.d

;;; Commentary:
;; This file is loaded after `init.el'. It is useful for additional configurations or package setups
;; that depend on the configurations in `init.el'.

;;; Code:

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
