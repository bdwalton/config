;; enable midnight mode buffer purging
(require 'midnight)
(midnight-delay-set 'midnight-delay "4:30am")

;; allow sgml/xml files to set indentation variables, etc.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((sgml-indent-step . 1) (sgml-indent-data . 1)))))

(column-number-mode t)                   ;; show column numbers
;; --- end of djcb's tips

;; snarfed from djcb's dotemacs
;; http://www.djcbsoftware.nl/dot-emacs.html

(defun my-indent-all ()
  "Mark the whole buffer and then indent it according to the mode rules."
  (interactive)
  (progn
    (indent-region (point-min) (point-max))))
