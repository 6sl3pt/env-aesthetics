(setq doom-gruvbox-dark-variant "soft")
(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "CaskaydiaMono Nerd Font" :size 12))

(setq +dashboard-functions
      `(+dashboard-widget-banner
        +dashboard-widget-name
        +dashboard-widget-date
        +dashboard-widget-shortmenu
        +dashboard-widget-footer
        +dashboard-widget-loaded)
      )

(defun +dashboard-draw-ascii-banner-fn ()
  "Read text file and return dashboard ASCII logo banner."
  (propertize
   (with-temp-buffer
     (insert-file-contents "~/.config/doom/dashboard/banner/creation-of-adam-circle.txt")
     (buffer-string))
   'face '+dashboard-banner)
  )

;;(setq fancy-splash-image "~/.config/doom/dashboard/banner/banner.svg")

(defun +dashboard-random-phrase ()
"Return a random phrase from a random .txt file."
(let* ((dir (expand-file-name "~/.config/doom/dashboard/phrase/"))
        (files (directory-files dir t "\\.txt\\'" t))
        (file (seq-random-elt files)))
    (when file
    (with-temp-buffer
        (insert-file-contents file)
        (let ((lines (seq-filter
                    (lambda (line)
                        (not (string-empty-p (string-trim line))))
                    (split-string (buffer-string) "\n" t))))
        (seq-random-elt lines))))))

(defun +dashboard-widget-footer ()
(+dashboard-insert
(propertize
    (format "\n“%s”\n" (+dashboard-random-phrase))
    'face `(:foreground ,(doom-color 'blue)))
))

(defun +dashboard-widget-date ()
  "Return today's date in a specific format."
  (+dashboard-insert
   (propertize
    (format "\n[ %s ]\n" (format-time-string "%A, %B %d %Y"))
    'face `(:foreground ,(doom-color 'fg)))
   ))

(defun +dashboard-widget-name ()
  "Return string of title name"
  (+dashboard-insert
   (propertize
    "- D O O M  E M A C S -"
    'face `(:foreground ,(doom-color 'grey)))
   ))

(after! doom-modeline
  (setq doom-modeline-time t
        display-time-format "%H:%M"
        display-time-default-load-average nil)
  (display-time-mode 1))

(setq org-directory "~/org/"
      org-agenda-files (directory-files-recursively org-directory "\\.org$"))

(after! org
  (setq org-log-done 'time
        org-tags-column -80))

(after! org
  (org-edna-mode 1))

(after! org
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "INPROGRESS(i)"
           "READY(r)"
           "HOLD(h)"
           "BLOCKED(b)"
           "|"
           "DONE(d)"
           "CANCEL(c)"))
        org-todo-keyword-faces
        `(("TODO"       :foreground ,(doom-color 'yellow))
          ("INPROGRESS" :foreground ,(doom-color 'teal))
          ("READY"      :foreground ,(doom-color 'blue))
          ("HOLD"       :foreground ,(doom-color 'violet))
          ("BLOCKED"    :foreground ,(doom-color 'red))
          ("DONE"       :foreground ,(doom-color 'green))
          ("CANCEL"     :foreground ,(doom-color 'magenta))))
  )

(use-package! org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("󰄿" "󰅃" "󰅀")))

(setq org-priority-faces
      `((?A :foreground ,(doom-color 'red))
        (?B :foreground ,(doom-color 'orange))
        (?C :foreground ,(doom-color 'teal))))

(use-package org-modern
  :hook
  (org-mode . org-modern-mode)
  :custom
  (org-modern-priority nil))

(after! org-modern
  (global-org-modern-mode 1)
  (setq org-modern-table t
        org-modern-table-vertical 1
        )
  )

(setq display-line-numbers-type 'relative)
(setq confirm-kill-emacs nil)
