;; custom configuration

(defun ruby-mode-indent ()
  (doom/set-indent-width 2))
(add-hook 'ruby-mode-hook 'ruby-mode-indent)

(setq-default doom-theme 'doom-xcode)
(defun load-doom-xcode-theme (frame)
  (select-frame frame)
  (load-theme 'doom-xcode t))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'load-doom-xcode-theme)
  (load-theme 'doom-xcode t))

;; (add-to-list 'auto-mode-alist
;;              '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
