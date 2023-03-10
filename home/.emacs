;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
(setq transient-mark-mode t)

(setq create-lockfiles nil)
;; Put all the lockfiles in one place (Doesn't seem to work in this version of emacs, or I have the command wrong
;; (setq lock-file-name-transforms
;;             '(("\\`/.*/\\([^/]+\\)\\'" "~/.emacs.d/lock-files/\\1" t)))


(setq epg-gpg-program "gpg2")

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))
;;(load "ruby-mode.el")
;;(load "yaml-mode.elc")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))
(require 'terraform-mode)
(add-to-list 'auto-mode-alist '("\\.tf$" . terraform-mode))

(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;(require 'ruby-mode.el)
;;(add-to-list 'load-path
(add-to-list 'auto-mode-alist
               '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist
               '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)


;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))



(defun perl-outline-mode ()
  "set customized outline minor mode for Perl"
  (interactive)
  (setq outline-regexp
	;; Remember that in emacs regexp that escaping for parens and pipes are opposite of normal.
	;; And that for this string, things need to be double escaped.
	;; Longer matches indicate a lower level
	;; There is some way to set outline-level as a function to explicitly say which level a match is
;;	"#!.\\|\\(pac\\)kage\\|sub\\|\\(=he\\)ad\\|\\(=po\\)d")
	"#!.\\|\\(pac\\)kage\\|sub\\|\\(=he\\)ad\\|\\(=po\\)d\\|.*\\(---{{{\\)\\|.*\\( }}}\\)")

;;	"#!.\\|#+.*\\({{\\)\\|\\(pac\\)kage\\|sub\\|\\(=he\\)ad\\|\\(=po\\)d")
;;  	"#*\\-*\\(#!.\\|{{\\|pac\\|sub\\|=he\\|=po\\)")
;;  	"^[ #\\-\\t]*\\(!.\\|{{{\\|package\\|sub\\|=head\\|=pod\\)")
  ;; (setq outline-heading-end-regexp
  ;; 	;; Regex looks for end of heading line. Not the end of the section. Only folds to end of line
  ;; 	"}}}")
  (outline-minor-mode))

(defun vim-outline-mode ()
  "set customized outline minor mode for Vim folding"
  (interactive)
  (setq outline-regexp
;;  	"[\\s-\\-#]+\\({{\\|}}}\\)")
    	"##---{{{\\|# }}}")
  (outline-minor-mode))



(defun set-vim-foldmarker (fmr)
  "Set Vim-type foldmarkers for the current buffer"
  (interactive "sSet local Vim foldmarker: ")
  (if (equal fmr "")
      (message "Abort")
    (setq fmr (regexp-quote fmr))
    (set (make-local-variable 'outline-regexp)
	 (concat ".*" fmr "\\([0-9]+\\)?"))
    (set (make-local-variable 'outline-level)
	 `(lambda ()
	    (save-excursion
	      (re-search-forward
	       ,(concat fmr "\\([0-9]+\\)") nil t)
	      (if (match-string 1)
		  (string-to-number (match-string 1))
		(string-to-number "0")))))))

;; (defun set-vim-foldmarker (fmr)
;;   "Set Vim-type foldmarkers for the current buffer"
;;   (interactive "sSet local Vim foldmarker: ")
;;   (if (equal fmr "")
;;       (message "Abort")
;;     (setq fmr (regexp-quote fmr))
;;     (set (make-local-variable 'outline-regexp)
;; 	 (concat ".*" fmr "\\([0-9]+\\)"))
;;     (set (make-local-variable 'outline-level)
;; 	 `(lambda ()
;; 	    (save-excursion
;; 	      (re-search-forward
;; 	       ,(concat fmr "\\([0-9]+\\)") nil t)
;; 	      (string-to-number (match-string 1)))))))

(global-set-key (kbd "C-<tab>") 'outline-toggle-children)

(setq perl-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq perl-indent-level 2)
		(flycheck-mode)
		(perl-outline-mode)
		;; (outline-minor-mode 1)
		;; (set-vim-foldmarker "{{{")
		)))


;; (require 'template)
;; (template-initialize)
;; (add-to-list 'auto-mode-alist '("\\.tt$" . html-mode))
;; (require 'catalyst-helper-functions)
;; (add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
(column-number-mode)
(global-hl-line-mode)

;; (setq auto-mode-alist
;;     (cons '("mplus." . auto-revert-tail-mode) auto-mode-alist))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(package-selected-packages '(terraform-mode ## flymake-perlcritic flycheck)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:weight extrabold))))
 '(link ((t (:foreground "color-27" :underline t))))
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(mmm-default-submode-face ((t nil)))
 '(nxml-element-local-name ((t (:inherit font-lock-function-name-face :foreground "light blue" :weight normal)))))

(defvar visual-wrap-column nil)
(defun set-visual-wrap-column (new-wrap-column &optional buffer)
        "Force visual line wrap at NEW-WRAP-COLUMN in BUFFER (defaults
    to current buffer) by setting the right-hand margin on every
    window that displays BUFFER.  A value of NIL or 0 for
    NEW-WRAP-COLUMN disables this behavior."
	(interactive (list (read-number "New visual wrap column, 0 to disable: " (or visual-wrap-column fill-column 0))))
	(if (and (numberp new-wrap-column)
		 (zerop new-wrap-column))
	    (setq new-wrap-column nil))
	(with-current-buffer (or buffer (current-buffer))
	  (visual-line-mode t)
	  (set (make-local-variable 'visual-wrap-column) new-wrap-column)
	  (add-hook 'window-configuration-change-hook 'update-visual-wrap-column nil t)
	  (let ((windows (get-buffer-window-list)))
	    (while windows
	      (when (window-live-p (car windows))
		(with-selected-window (car windows)
		  (update-visual-wrap-column)))
	      (setq windows (cdr windows))))))
(defun update-visual-wrap-column ()
  (if (not visual-wrap-column)
      (set-window-margins nil nil)
    (let* ((current-margins (window-margins))
	   (right-margin (or (cdr current-margins) 0))
	   (current-width (window-width))
	   (current-available (+ current-width right-margin)))
      (if (<= current-available visual-wrap-column)
	  (set-window-margins nil (car current-margins))
	(set-window-margins nil (car current-margins)
			                                    (- current-available visual-wrap-column))))))

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.


;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
