;; automatically enable cfengine mode for the following file regexes
(setq auto-mode-alist
      (append
       '(("cf\\." . cfengine-mode)
	 ("cfagent.conf" . cfengine-mode)
	 ("update.conf" . cfengine-mode)
	 ("cfrun.hosts" . cfengine-mode)
	 )
       auto-mode-alist))
