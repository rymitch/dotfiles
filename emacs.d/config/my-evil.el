(use-package evil-leader
  :commands (evil-leader-mode)
  :ensure evil-leader
  :demand evil-leader
  :init
  (global-evil-leader-mode t)
  :config
  (progn
    (evil-leader/set-leader ",")
    (evil-leader/set-key    "w"   'save-buffer)
    (evil-leader/set-key    "qq"  'kill-this-buffer)
    (evil-leader/set-key    "Q"   'kill-buffer-and-window)
    (evil-leader/set-key    "e"   'pp-eval-last-sexp)
    (evil-leader/set-key    "h"   'dired-jump)

    ;; window splits
    ;;
    ;; mnemonic:
    ;;
    ;;    |       vertical split      (technically it's the `\` key)
    ;;    -       horizontal split
    ;;
    (evil-leader/set-key    "\\"  'split-window-horizontally)
    (evil-leader/set-key    "-"   'split-window-vertically)
    (evil-leader/set-key    "e"   'pp-eval-last-sexp)
    (evil-leader/set-key    "TAB" 'my-hop-around-buffers)
    (evil-leader/set-key    ","   'other-window)


    (evil-leader/set-key-for-mode 'c-mode
      "." 'semantic-ia-fast-jump)

    ;; j -> "jump"
    (evil-leader/set-key    "jf"  'ffap)
    (evil-leader/set-key    "cl"  'my-flycheck-list-errors)
    )
  )

(use-package evil
  :ensure evil
  :config
  (progn
    (evil-mode 1)
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-w-in-emacs-state t)
    (setq evil-search-module        'isearch)
    (setq evil-magic                'very-magic)
    (setq evil-want-fine-undo t)
    (setq evil-want-change-word-to-end t)
    ))

(defun highlight-remove-all ()
  (interactive)
  (hi-lock-mode -1)
  (hi-lock-mode 1))
(defun search-highlight-persist ()
  (highlight-regexp (car-safe (if isearch-regexp
                                  regexp-search-ring
                                search-ring)) (facep 'hi-yellow)))
(defadvice isearch-exit (after isearch-hl-persist activate)
  (highlight-remove-all)
  (search-highlight-persist))
(defadvice evil-search-incrementally (after evil-search-hl-persist activate)
  (highlight-remove-all)
  (search-highlight-persist))

(provide 'my-evil)
