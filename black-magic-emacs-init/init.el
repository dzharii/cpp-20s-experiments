;; REAL INIT:
(setq package-enable-at-startup nil) ;; radian-software/straight.el
(require 'org)
(org-babel-load-file (expand-file-name "./black-magic-emacs-init/init-config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company helm all-the-icons moody black-magic)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
