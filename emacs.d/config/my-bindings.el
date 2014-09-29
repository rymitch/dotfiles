; Make j/k go up/down across wrapped lines.
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

; Simple buffer management.
(define-key evil-normal-state-map (kbd "C-d") 'evil-delete-buffer)
(define-key evil-normal-state-map (kbd "C-h") 'previous-buffer)
(define-key evil-normal-state-map (kbd "C-l") 'evil-next-buffer)

; ESC quits minibuffers.
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

; Slime.
(evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
  'elisp-slime-nav-describe-elisp-thing-at-point)

; Open a term.
(evil-leader/set-key "`" 'visit-term-buffer)

; Open the silver searcher.
(evil-leader/set-key "a" 'ag-project)

; Reformat the current paragraph.
(defun reformat-current-paragraph ()
  (interactive)
  (let ((beg (save-excursion (backward-paragraph) (point)))
        (end (save-excursion (forward-paragraph) (point))))
    (evil-fill-and-move beg end)))
(evil-leader/set-key "r" 'reformat-current-paragraph)

(provide 'my-bindings)
