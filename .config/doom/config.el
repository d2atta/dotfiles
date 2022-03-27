(setq user-full-name "Debarghya Datta"
      user-mail-address "debarghya.datta89@gmail.com")

(setq doom-font (font-spec :family "monospace" :size 19)
      doom-big-font (font-spec :family "Hack Nerd Font" :size 25)
      doom-variable-pitch (font-spec :family "ETBembo" :size 22))

(defun synchronize-theme ()
  (let* ((light-theme 'doom-one)
         (dark-theme 'doom-moonlight)
         (start-time-light-theme 6)
         (end-time-light-theme 18)
         (hour (string-to-number (substring (current-time-string) 11 13)))
         (next-theme (if (member hour (number-sequence start-time-light-theme end-time-light-theme))
                         light-theme dark-theme)))
    (when (not (equal doom-theme next-theme))
      (setq doom-theme next-theme))))

(synchronize-theme)

(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(setq display-line-numbers-type 'relative)
(whitespace-mode t)

(after! org
    (setq org-directory "~/dox/org/"
          org-agenda-files '("~/dox/org/agenda.org")
          org-ellipsis "  "
          org-cycle-separator-lines 2
          org-pretty-entities t
          org-startup-with-inline-images t
          org-image-actual-width '(300)
          org-src-window-setup 'current-window
          org-superstar-headline-bullets-list '(" ")
          ;; org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
          ;; org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦))
          org-log-done 'time
          org-hide-emphasis-markers t
          org-link-abbrev-alist
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/"))
          org-todo-keywords
              '((sequence
              "TODO(t)"
              "PROJ(p)"
              "STUDY(s)"
              "WAIT(w)"
              "|"
              "DONE(d)"
              "CANCELLED(c)" )))
    (set-popup-rule! "^\\*Org Src" :ignore t))

(add-hook 'org-mode-hook (lambda ()
                           (+zen/toggle +1)
                           (setq display-line-numbers nil)
                           (variable-pitch-mode +1)
                           ))

(setq org-src-window-setup 'current-window)

(setq org-re-reveal-root
      "file:///home/devildev/dox/reveal.js")
(setq org-re-reveal-plugins '(highlight))
(setq org-re-reveal-highlight-css
      "file:///home/devildev/dox/reveal.js/plugin/highlight/monokai.css")

(setq +zen-text-scale 0.8)
(defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode gfm-mode Info-mode)
  "Modes that `mixed-pitch-mode' should be enabled in, but only after UI initialisation.")
(defun init-mixed-pitch-h ()
  "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'.
Also immediately enables `mixed-pitch-modes' if currently in one of the modes."
  (when (memq major-mode mixed-pitch-modes)
    (mixed-pitch-mode 1))
  (dolist (hook mixed-pitch-modes)
    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)
