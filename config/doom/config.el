;; custom configuration

(defun ruby-mode-indent ()
  (doom/set-indent-width 2))
(add-hook 'ruby-mode-hook 'ruby-mode-indent)

(setq-default doom-theme 'doom-gruvbox)
(defun load-doom-gruvbox-theme (frame)
  (select-frame frame)
  (load-theme 'doom-gruvbox t))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'load-doom-gruvbox-theme)
  (load-theme 'doom-gruvbox t))

;; (add-to-list 'auto-mode-alist
;;              '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
