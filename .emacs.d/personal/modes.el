(require 'erc)
(require 'org)
(require 'python)
(require 'company)
(require 'slime)

;; My modes
(message "Modos do Manoel")

;; wakatime on all files
(global-wakatime-mode)
;; move to trash on deleting
(setq delete-by-moving-to-trash t)

;; always active highlight on source from org-files
(setq org-src-fontify-natively t)

;; no tabs, never.
(setq-default indent-tabs-mode nil)
;; disable shell completion native
;; to avoid warning on running python shell at emacs
(setq python-shell-completion-native-enable nil)

;; add more tags for TODO list on org-mode
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;; windows mode section
(when (eq system-type 'windows-nt)
  ;; disable gdb because is buggy using from windows
  ;; use gud-gdb instead
  (put 'gdb 'disabled t)
  (require 'intero)
  (intero-global-mode))

;; this avoid crash on daemon-mode at linux when
;; a frame is closed
;; more info on:
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Clipboard.html
(when (eq system-type 'gnu/linux)
  (setq x-select-enable-clipboard-manager nil))

;; add company tooltip align annotations
(setq company-tooltip-align-annotations t)

;; add slime-company completion tool to slime-contribs
(push 'slime-company slime-contribs)

;; setup irc autologin channels
(setq erc-autojoin-channels-alist '(("freenode.net" "#haskell" "#python" "#lisp")))

;; add company backend company-ghc
;; need ghc-mod installed system-wide
(add-to-list 'company-backends '(company-ghc :with company-dabbrev-code))
