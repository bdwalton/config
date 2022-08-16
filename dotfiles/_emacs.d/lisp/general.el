;; enable midnight mode buffer purging
(require 'midnight)
(midnight-delay-set 'midnight-delay "4:30am")

(column-number-mode t)                   ;; show column numbers
;; --- end of djcb's tips

;; snarfed from djcb's dotemacs
;; http://www.djcbsoftware.nl/dot-emacs.html

(defun my-indent-all ()
  "Mark the whole buffer and then indent it according to the mode rules."
  (interactive)
  (progn
    (indent-region (point-min) (point-max))))
