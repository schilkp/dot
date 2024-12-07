(defconst user-init-dir "~/.config/emacs/")
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;; Disable the splash screen
(setq inhibit-splash-screen t)

(load-user-file "schilk/elpaca.el")
(load-user-file "schilk/evil.el")
(load-user-file "schilk/fzf.el")

(use-package catppuccin-theme :ensure (:wait t) :demand t)
(load-theme 'catppuccin :no-confirm)

;; set transparency in GUI
(set-frame-parameter nil 'alpha-background 80)

;; set transparency in terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;; disable menu & tool bar
(menu-bar-mode -1)
(tool-bar-mode -1) 

;; set ui scale in terminal
(set-face-attribute 'default nil :height 130) 

(evil-define-key 'normal 'global (kbd "SPC x") 'org-toggle-checkbox)
