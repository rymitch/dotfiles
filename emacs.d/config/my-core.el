;; Don't show the toolbar.
(tool-bar-mode -1)

;; Break long lines at word boundaries.
(visual-line-mode 1)

;; Turn off backup files.
(setq make-backup-files nil)

;; Turn off lockfiles.
(setq create-lockfiles nil)

;; Use spaces for indent.
(setq-default indent-tabs-mode nil)

;; Number columns in the status bar.
(column-number-mode)

;; Require a trailing newline.
(setq require-final-newline t)

;; Hide startup messages.
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; I never look at right-side fringes. Do you?
(set-fringe-style '(8 . 0))

;; Don't put intitial text in scratch buffer.
(setq initial-scratch-message nil)

;; from <https://github.com/bling/dotemacs/>
(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

;; Disable vertical scrollbars in all frames.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

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
(prefer-coding-system 'utf-8-unix)

;; One space after sentences.
(setq sentence-end-double-space nil)

;; Flash the frame to represent a bell.
(setq visible-bell t)
;; nevermind that's annoying
(setq ring-bell-function 'ignore)

;; Set the default font (only matters in graphical mode).
(when window-system
  (progn
    (set-face-attribute 'default nil :font "Consolas-10")
    (set-frame-font "Consolas-10" nil t)))

;; Highlight matching pairs of parentheses.
(show-paren-mode 1)

;; .ms files are scheme unit test files.
(setq auto-mode-alist (cons '("\\.ms" . scheme-mode) auto-mode-alist))

;; Set the initial window size.
(when window-system
  (setq initial-frame-alist
    `((top . 0)
      (left . 0)
      (width . 112)
      (height . 64))))

;; Run as a server - accept input from emacsclient.
(server-start)

(provide 'my-core)
