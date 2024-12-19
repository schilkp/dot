
; === BASICS ===================================================================

; Disable UI elements:
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

; === ELPACA ===================================================================

;; Download + install elpaca.
;; Taken from elpaca README: https://github.com/progfolio/elpaca

(defvar elpaca-installer-version 0.8)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install elpaca use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

; Always lazy-load per default:
(setq use-package-always-defer t)

; (use-package foo
;     :ensure t         ; Ask system package manager to install if not present
;     :defer t          ; Do not auto-load/defer
;     :demand t         ; Require immediate load, even if defer t is default
;     :if (condition)   ; Only load if condition is met
;     :after (peter)    ; Load after package peter
;     :requires (peter) ; Load after package peter, ONLY if peter was loaded
;     :init             ; Run before package is loaded (not lazy!)
;     :config)          ; Run after package is loaded.

; === EMACS ====================================================================

(use-package emacs
  :init
  ; Disable splash screen and welcome msg:
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message ""))
  (setq inhibit-splash-screen t)
  ; No backup files:
  (setq make-backup-files nil)
  ; Allow y/n instead of yes/no
  (defalias 'yes-or-no-p 'y-or-n-p)
  ; Use unicode
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  ; Use escape to escape:
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  ; Make completion case-insensitive:
  (setq completion-ignore-case t)
  )

; === EVIL =====================================================================

(use-package evil
    :ensure t
    :demand t

    :init
    (setq evil-want-keybinding nil)

    :config
    (evil-mode 1)
    )

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

; === WHICH-KEY ================================================================

(use-package which-key
  :ensure t
  :demand t
  :init
  (setq which-key-idle-delay 0.2) ;
  :config
  (which-key-mode))

; === IVY ======================================================================

;(use-package ivy
;  :demand t
;  :ensure t
;  :config
;  (ivy-mode))

(use-package vertico
  :demand t
  :ensure t
  :init
  (vertico-mode))

(use-package consult
  :ensure t

  :init

  :config
  (setq consult-async-min-input 1)
  (setq consult-async-refresh-delay 0.01)
  (setq consult-async-input-debounce 0)
  (setq consult-async-input-throttle 0)
)

; === ORG-ROAM =================================================================

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-directory (file-truename "~/org-roam"))
  (evil-define-key 'normal 'global (kbd "SPC fn") 'org-roam-node-find)
  (evil-define-key 'normal 'global (kbd "SPC nf") 'org-roam-node-find)
  (evil-define-key 'normal 'global (kbd "SPC ni") 'org-roam-node-insert)

  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)))
  )


(use-package org-roam-ui
  :ensure t)

; === STYLING ==================================================================

(use-package
  catppuccin-theme
  :ensure t
  :demand t
  :config
  (load-theme 'catppuccin :no-confirm)
)

;; set transparency in GUI
(set-frame-parameter nil 'alpha-background 80)

;; set transparency in terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;; set ui scale in terminal
(set-face-attribute 'default nil :height 130)
