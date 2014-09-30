(use-package markdown-mode
  :ensure markdown-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
    )
  )

(provide 'my-markdown)
