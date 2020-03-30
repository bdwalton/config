;; So that we know to look up included files in our local directory too.

;; Activate melpa package manipulation.
;; Do this early so that anything depending on packages will be able to
;; find the package paths, etc.
(when (>= emacs-major-version 24)
	(require 'package)
	(add-to-list
	 'package-archives
	 '("melpa" . "http://melpa.org/packages/")
	 t)
	(package-initialize))

(defconst user-init-dir
  (expand-file-name
   (concat "~" (getenv "LOGNAME") "/.emacs.d/")
   )
  "User init dir")

(add-to-list 'load-path user-init-dir)

;; make adding other paths easier
(defun extra-user-path (p)
  "Add p to load-path (relative to ~/.emacs.d/)"
  (add-to-list 'load-path (concat user-init-dir p)))

(defun cond-load-file (f)
  "Conditionally load a file based on whether or not it exists"
  (if (file-exists-p f)
      (load f)
      (print (concat "File " f " skipped because it wasn't found."))
      ))

;; some generic settings that should work everywhere.
(load-library "general")

;; keybindings that we want everywhere.
(load-library "keybindings")

;; automatically load all of the .el files in our modes/ directory
(mapc 'load-library
      (directory-files (concat user-init-dir "modes") t "\\.el\\'"))

;; finally, always start with ~/ as the current directory
(cd (getenv "HOME"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
	 (quote
		("19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" default)))
 '(safe-local-variable-values
	 (quote
		((sgml-parent-document . "../machines.xml")
		 (sgml-indent-step . 1)
		 (sgml-indent-data . 1)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; now pull in the optional site-local config
(setq site-local-lib (concat "emacs-" (getenv "BDW_CONFIG_TYPE") ".el"))
(if (locate-library site-local-lib)
    (load-library site-local-lib)
  (print "Not loading site local library."))
