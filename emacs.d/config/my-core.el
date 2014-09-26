;; Don't show those horrible buttons
(tool-bar-mode -1)

;; break long lines at word boundaries
(visual-line-mode 1)

;; lockfiles are evil.
(setq create-lockfiles nil)

;; also tabs are evil
(setq-default indent-tabs-mode nil)

;; number columns in the status bar
(column-number-mode)

;; require a trailing newline
(setq require-final-newline t)

;; I never look at right-side fringes. Do you?
(set-fringe-style '(8 . 0))

;; don't put intitial text in scratch buffer
(setq initial-scratch-message nil)

;; Hide startup messages
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; Disable vertical scrollbars in all frames.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Turn off backup files.
(setq make-backup-files nil)

;; Only scroll one line when near the bottom of the screen, instead
;; of jumping the screen around.
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)

;; Let me write `y` or `n` even for important stuff that would normally require
;; me to fully type `yes` or `no`.
(defalias 'yes-or-no-p 'y-or-n-p)

;; UTF-8 everything!
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; This isn't a typewriter (even if it is a terminal); one space after sentences,
;; please.
(setq sentence-end-double-space nil)

;; Flash the frame to represent a bell.
(setq visible-bell t)
;; nevermind that's annoying
(setq ring-bell-function 'ignore)

;; Set the default font (only matters in graphical mode).
(when window-system
  (progn
    (set-face-attribute 'default nil :font "Consolas-10")
    (set-frame-font "Consolas-10" nil t)
))

;; Highlight matching pairs of parentheses.
(show-paren-mode 1)

(provide 'my-core)
