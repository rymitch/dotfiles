(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(use-package elisp-slime-nav
  :ensure elisp-slime-nav
  :diminish elisp-slime-nav-mode
  :init (progn
          (defun my-lisp-hook ()
            (progn
              (elisp-slime-nav-mode)
              (turn-on-eldoc-mode)
              )
            )
          (add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
          (add-hook 'lisp-interaction-mode-hook 'my-lisp-hook)
          (add-hook 'ielm-mode-hook 'my-lisp-hook)
          )
  )

(provide 'my-elisp)
