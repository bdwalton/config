;;; el-init-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "el-init" "el-init.el" (0 0 0 0))
;;; Generated autoloads from el-init.el

(autoload 'el-init-provide "el-init" "\
Call `provide' with the file name as a feature name." nil nil)

(autoload 'el-init-load "el-init" "\
Load configuration files in DIRECTORY with `require'.

DIRECTORY is a path of a directory which is root of configuration files.
SUBDIRECTORIES is a list of subdirectories of DIRECTORY; its element is
a string or a list like (\"path\" t).
 means including all the directories in \"path\".
OVERRIDE-ONLY-INIT-FILES is a flag to use overridden `require' only for
configuration files.
OVERRIDE is a flag to use overridden `require' when `require' called in
configuration files.

The mechanism:
- Add SUBDIRECTORIES to `load-path'
- Call `require' for all the configure files in SUBDIRECTORIES

\(fn DIRECTORY &key (SUBDIRECTORIES el-init-subdirectories) (WRAPPERS el-init-wrappers) (OVERRIDE-ONLY-INIT-FILES el-init-override-only-init-files-p) (OVERRIDE el-init-overridep))" nil nil)

(register-definition-prefixes "el-init" '("el-init-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; el-init-autoloads.el ends here
