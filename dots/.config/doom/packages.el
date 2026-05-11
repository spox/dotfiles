;; custom packages to install
;;

(package! protobuf-mode)
;;(unpin! consult)
;; (package! enh-ruby-mode
;;   :recipe (:host github :repo "zenspider/enhanced-ruby-mode"))
;; (package! company-inf-ruby)
;; (package! inf-ruby)
;; (package! minitest)
;; (package! rake)
;; (package! robe)
;; (package! rspec-mode)

(use-package doom-themes
  :ensure t
  :config
  (doom-themes-treemacs-config)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))


