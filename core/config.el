;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Misc 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'e 'evil-edit)

(dolist (turn-off-mode '(tool-bar-mode
			 scroll-bar-mode))
  (funcall turn-off-mode -1))

(fringe-mode '(0 . 0))

(dolist (turn-off-mode '(dirtrack-mode
			show-paren-mode))
  (funcall turn-off-mode 1))

(setq-default fringes-outside-margins t)

(setq-default display-line-numbers-width 3)
(setq-default org-agenda-span 'month)
(setq-default fringes-outside-margins t)
(set-face-attribute 'cursor nil :background "#fff")
(set-face-attribute 'window-divider nil :foreground "#222933")
(menu-bar-bottom-and-right-window-divider)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

(setq show-paren-style 'parenthesis
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1
      display-time-24hr-format t
      display-battery-mode t
      display-time-mode t
      dired-use-ls-dired nil
      dired-listing-switches "-alh"
      enable-recursive-minibuffers t
      evil-snipe-smart-case t
      evil-snipe-scope 'line
      evil-snipe-repeat-scope 'visible
      frame-resize-pixelwise t
      ns-use-native-fullscreen t
      ns-auto-hide-menu-bar t
      evil-snipe-char-fold t
      company-show-numbers t
      evil-snipe-spillover-scope t
      inhibit-startup-screen t
      ns-use-native-fullscreen nil
      backup-inhibited t
      visible-bell -1
      ring-bell-function 'ignore
      display-line-numbers-type 'relative
      +ivy-buffer-preview t
      wdired-allow-to-change-permissions t
      show-paren-style 'parenthesis)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'conf-mode-hook #'display-line-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Org 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-fontify-whole-heading-line t
      org-fontify-quote-and-verse-blocks t
      org-fontify-done-headline t
      org-hide-emphasis-markers t
      org-enforce-todo-dependencies t
      org-default-notes-file  "~/org/org.org"
      org-habit-show-habits-only-for-today nil
      org-agenda-files '("~/org/")
      org-indent-indentation-per-level 1
      org-src-preserve-indentation t
      org-agenda-include-deadlines t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-link-elisp-confirm-function nil
      org-hide-leading-stars t
      org-adapt-indentation t
      org-odd-levels-only t
      org-use-property-inheritance t)

(setq-default org-agenda-span 'month)

(add-hook 'org-mode-hook (lambda () (text-scale-adjust 1)))

(with-no-warnings
  (custom-declare-face '+org-todo-active  '((t (:inherit (bold font-lock-constant-face org-todo)))) "")
  (custom-declare-face '+org-todo-project '((t (:inherit (bold font-lock-doc-face org-todo)))) "")
  (custom-declare-face '+org-todo-onhold  '((t (:inherit (bold warning org-todo)))) ""))

(let* ((done-color "#48514f")
       (todo '(:foreground "#ffad37" :weight ultra-bold))
       (done `(:foreground ,done-color :weight ultra-bold :strike-through t))
       (blocked `(:foreground "#e6712e" :weight ultra-bold :underline t)))
  (set-face-attribute 'org-tag nil :foreground done-color)
  (setq org-superstar-headline-bullets-list '("#" "○" "+" "~" "-")
	org-todo-keywords
	'((list "TODO(t)" "PROJ(p)" "ON-GOING(s)" "BLOCKED(w)" "HOLD(h)" "|" "DONE(d)" "KILL(k)"))
	org-todo-keyword-faces
	`(("TODO" ,@todo)
	  ("PROJ" ,@todo)
	  ("ON-GOING" ,@todo)
	  ("HOLD" ,@blocked)
	  ("BLOCKED" ,@blocked)
	  ("DONE" ,@done)
	  ("KILL" ,@done))))

(let ((color (face-foreground 'default nil 'default)))
  (dolist (face '(org-level-1
		  org-level-2
		  org-level-3
		  org-level-4
		  org-level-5
		  org-level-6
		  org-level-7
		  org-level-8))
    (set-face-attribute face nil :foreground color :weight 'ultra-bold :family "Serif Sans Serif")))

(dolist (face '(org-block-begin-line
		org-block-end-line
		org-level-1
		org-code
		org-block))
  (set-face-attribute face nil :background "#242c36" :extend t))

(dolist (face '(org-block-begin-line
		org-block-end-line
		org-level-1))
  (set-face-attribute face nil :box '(:line-width 1 :color "#222933")))


(set-face-attribute 'org-level-1 nil :height 1.3 )

(set-face-attribute 'org-headline-done nil :foreground "#545454" :strike-through t)

(setq org-log-done 'time)

(add-hook 'org-mode-hook 'org-indent-mode)

;;; Babel
(org-babel-do-load-languages
 'org-babel-load-languages '((shell . t)
			     (awk . t)
			     (clojure . t)
			     (emacs-lisp . t)
			     (haskell . t)
			     (gnuplot . t)
			     (lisp . t)
			     (makefile . t)
			     (org . t)
			     (ruby . t)
			     (sqlite . t)
			     (sql . t)
			     (C . t)))

(add-hook 'org-mode-hook 'org-overview)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Modeline 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq rubicon--modeline-format
      (list ""
	    '(:eval
	      (rubicon/relative-default-dir))
	    "%b @ %p"
	    " | "
	    'mode-name
	    " |"
	    'vc-mode
	    " | "
	    'display-time-string
	    " | "
	    'battery-mode-line-string))

(dolist (enable-modeline-mode-hook (list 'prog-mode-hook
					 'yaml-mode-hook
					 'markdown-mode-hook
					 'eshell-mode-hook
					 'org-mode-hook))
  (add-hook enable-modeline-mode-hook 'rubicon/enable-modeline))

(let ((background-color "#FFF"))
  (defface rubicon-modeline-active
    (rubicon--modeline-face 'mode-line background-color)
    "Face used when modeline is enabled and active"
    :group 'rubicon-faces)
  (defface rubicon-modeline-inactive
    (rubicon--modeline-face 'mode-line-inactive background-color)
    "Face used when modeline is enabled and inactive"
    :group 'rubicon-faces))

(setq rubicon-home-path (expand-file-name "~"))
(setq rubicon--home-path-rg-starts-with (concat "^" rubicon-home-path))

(dolist (remapping '((mode-line-inactive . rubicon-modeline-inactive)
		     (mode-line . rubicon-modeline-active)))
  (add-to-list 'face-remapping-alist remapping t))

(dolist (enable-modeline-mode-hook (list 'prog-mode-hook
					 'yaml-mode-hook
					 'markdown-mode-hook
					 'eshell-mode-hook
					 'org-mode-hook))
  (add-hook enable-modeline-mode-hook 'rubicon/enable-modeline))