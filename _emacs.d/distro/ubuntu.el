;; the git stuff doesn't happen automatically in ubuntu.
(add-to-list 'load-path "/usr/share/doc/git-core/contrib/emacs/")
(load-library "git.el")
(load-library "git-blame.el")
(load-library "vc-git.el")
(add-to-list 'vc-handled-backends 'GIT)

