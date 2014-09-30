(define-key evil-normal-state-map (kbd "C-d") 'evil-delete-buffer)
(define-key evil-normal-state-map (kbd "C-h") 'previous-buffer)
(define-key evil-normal-state-map (kbd "C-l") 'evil-next-buffer)

(evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
  'elisp-slime-nav-describe-elisp-thing-at-point)

(evil-leader/set-key "`" 'visit-term-buffer)

(evil-leader/set-key "a" 'ag-project)

(provide 'my-bindings)
