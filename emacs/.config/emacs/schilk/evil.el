;; TODO: Enable evil asynchronously after elpaca has loaded it?
;; TODO: WTF is use-package?

;; Expands to: (elpaca evil (use-package evil :demand t))
;; Note: :wait forces sync loading of evil mode.
(use-package evil :ensure (:wait t) :demand t)

;; Enable Evil
(require 'evil)
(evil-mode 1)
