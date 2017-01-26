;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another
;; package (Gnus, auth-source, ...).
(load-file "~/.emacs.d/vendor/cedet/cedet-devel-load.el")

;; Melpa is a package manager for emacs
(require 'package)
;; (add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; -------- Arduino setup --------

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Configure arduino OS X dirs.
(setq ede-arduino-appdir "/Applications/Arduino.app/Contents/Java")

;; Arduino mode
(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;; -------------------------------

;; Erlang official setup
(setq load-path (cons  "/usr/local/lib/erlang/lib/tools-2.6.12/emacs" load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)
(setq erlang-electric-commands '())
;; (require 'erlang-flymake)

(defun erlang-enable-edts ()
  (edts-mode))

(add-hook 'erlang-mode-hook 'erlang-enable-edts)

;; Erlang Development Tool Suite - EDTS
;; (add-hook 'after-init-hook 'my-after-init-hook)
;; (defun my-after-init-hook ()
;;   (require 'edts-start))

;; ---------------------------------------------------
;; From Aaron's .emacs (ref. https://github.com/AeroNotix/dotfiles/blob/master/.emacs)

;; *Messages* buffer, literally who uses it?
(setq-default message-log-max nil)
(let ((buffer "*Messages*"))
  (and (get-buffer buffer)
       (kill-buffer buffer)))

;; Disabled *Completions*
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; {Down,Up}case region is pretty useful
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Erlang Development Tool Suite - EDTS
(defun erlang-enable-edts ()
  (edts-mode))

(add-hook 'erlang-mode-hook 'erlang-enable-edts)

;; ---------------------------------------------------

;; Disable *Compile-Log*
(let ((buffer "*Compile-Log*"))
  (and (get-buffer buffer)
       (kill-buffer buffer)))

;; Slime mode Elisp and Common Lisp
;; setup load-path and autoloads
; (add-to-list 'load-path "/usr/local/lib/slime")
; (require 'slime-autoloads)
;; Set your lisp system and, optionally, some contribs
; (setq inferior-lisp-program "/usr/local/bin/sbcl")
;; (setq inferior-lisp-program "/usr/local/bin/clisp")
; (setq slime-contribs '(slime-fancy))

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; 4 Spaces instead of tabs
(setq erlang-indent-level 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Highlights trailing spaces, long lines and empty spaces
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing tab-mark))
(set-face-attribute 'whitespace-line nil
                    :background "#555"
                    :foreground "red"
                    :weight 'bold)
(global-whitespace-mode 1)

;; Highlights tabs and spaces
(setq whitespace-display-mappings
      '((space-mark   ?\    [?\xB7]     [?.])   ; space
        (space-mark   ?\xA0 [?\xA4]     [?_])   ; hard space
        (tab-mark   ?\t   [?\xBB ?\t] [?\\ ?\t])    ; tab
        ;; (newline-mark ?\n   [?\xB6 ?\n] [?$ ?\n]) ; end-of-line
        ))

;; Shows fancy line numbers
(global-linum-mode)

;; Wrangler tool setup
; (add-to-list 'load-path
;              "/usr/local/lib/erlang/lib/wrangler-1.1.01/elisp")
; (require 'wrangler)

;; Flymake config to locate libraries
(add-to-list 'load-path "~/.emacs.d/erlang-rig/")
(require 'rebar-config)

;; Delete selection content when typing
(delete-selection-mode t)

;; Magit PR setup
;; (require 'magit-gh-pulls)
;; (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

;; Move emacs backup files away
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

;; Ignore ct log files during grep
(eval-after-load 'grep
  '(progn
     (add-to-list 'grep-find-ignored-directories "ct_run.test@*")))
(add-hook 'grep-mode-hook (lambda () (toggle-truncate-lines 1)))

;; Yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (misterioso)))
 '(dired-use-ls-dired nil)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(ede-project-directories (quote ("/Users/maxdrift/Code/me/RFID522-Door-Unlock")))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/")
 '(mac-option-modifier (quote meta))
 '(ns-alternate-modifier (quote meta))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
