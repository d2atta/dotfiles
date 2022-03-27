(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212337" "#ff757f" "#c3e88d" "#ffc777" "#82aaff" "#c099ff" "#b4f9f8" "#c8d3f5"])
 '(custom-safe-themes
   '("d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" default))
 '(exwm-floating-border-color "#161a2a")
 '(fci-rule-color "#444a73")
 '(highlight-tail-colors
   ((("#31363f" "#31363f" "green")
     . 0)
    (("#2f384a" "#2f384a" "brightcyan")
     . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#161a2a" "#82aaff"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#161a2a" "#c3e88d"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#161a2a" "#444a73"))
 '(objed-cursor-color "#ff757f")
 '(pdf-view-midnight-colors (cons "#c8d3f5" "#212337"))
 '(rustic-ansi-faces
   ["#212337" "#ff757f" "#c3e88d" "#ffc777" "#82aaff" "#c099ff" "#b4f9f8" "#c8d3f5"])
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
           (lambda nil
             (if
                 (y-or-n-p "Tangle?")
                 (call-interactively 'org-babel-tangle)))
           nil t)
     (eval add-hook 'after-save-hook
           (lambda nil
             (if
                 (y-or-n-p "Tangle?")
                 (org-babel-tangle)))
           nil t)))
 '(vc-annotate-background "#212337")
 '(vc-annotate-color-map
   (list
    (cons 20 "#c3e88d")
    (cons 40 "#d7dd85")
    (cons 60 "#ebd27e")
    (cons 80 "#ffc777")
    (cons 100 "#ffb76e")
    (cons 120 "#ffa866")
    (cons 140 "#ff995e")
    (cons 160 "#ea9993")
    (cons 180 "#d599c9")
    (cons 200 "#c099ff")
    (cons 220 "#d58dd4")
    (cons 240 "#ea81a9")
    (cons 260 "#ff757f")
    (cons 280 "#d06a7c")
    (cons 300 "#a15f79")
    (cons 320 "#725476")
    (cons 340 "#444a73")
    (cons 360 "#444a73")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-block-begin-line ((t (:inherit fixed-pitch :height 0.8))))
 '(org-block-end-line ((t (:inherit fixed-pitch :height 0.8))))
 '(org-date ((t (:inherit outline-3 :height 1.2))))
 '(org-document-info-keyword ((t (:inherit fixed-pitch :height 0.8))))
 '(org-document-title ((t (:inherit doom-variable-pitch :height 1.3))))
 '(org-drawer ((t (:inherit fixed-pitch :height 0.8))))
 '(org-elipsis ((t (:underline nil))))
 '(org-indent ((t (:inherit (org-hide org fixed-pitch) :underline nil))))
 '(org-level-1 ((t (:inherit doom-variable-pitch :height 1.3))))
 '(org-level-2 ((t (:inherit doom-variable-pitch :height 1.2))))
 '(org-level-3 ((t (:inherit doom-variable-pitch :height 1.1))))
 '(org-level-4 ((t (:inherit doom-variable-pitch :height 1.1))))
 '(org-level-5 ((t (:inherit doom-variable-pitch :height 1.0))))
 '(org-meta-line ((t (:inherit fixed-pitch :height 0.8))))
 '(org-property-value ((t (:inherit fixed-pitch :height 0.8))) t)
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-verbatim ((t (:inherit fixed-pitch)))))
