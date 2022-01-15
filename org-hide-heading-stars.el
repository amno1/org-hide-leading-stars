;;; org-babel-hide-markers.el --- Hide org-babel source code markers  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Arthur Miller

;; Author: Arthur Miller <arthur.miller@live.com>
;; Keywords: convenience, outlines, tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; Author: Arthur Miller
;; Version: 0.0.1
;; Keywords: tools convenience
;; Package-Requires: ((emacs "25.1"))
;; URL: https://github.com/amno1/org-babel-hide-markers-mode

;;; Commentary:

;; A minor mode to help reduce clutter in org-mode files by
;; hiding/unhiding leading stars for headings in org-mode.
;;
;; To hide all markers turn on org-hbm-mode by
;;
;;          `M-x org-babel-hide-markers-mode.'
;;
;; To turn it off execute the same command.

;;; Issues

;;; Code:
(defgroup org-hide-heading-stars nil
  "Hide babel source code markers in org-mode."
  :prefix "org-hide-heading-stars-"
  :group 'org-babel)

(defvar org-hide-heading-stars--re "^[ \t]*\\*+"
  "Regex used to recognize source block markers.")

(defun org-hide-heading-stars--update-headings (visibility)
  "Update invisible property to VISIBILITY for markers in the current buffer."
  (save-excursion
    (goto-char (point-min))
    (with-silent-modifications
      (while (re-search-forward org-hide-heading-stars--re nil t)
          (put-text-property
           (match-beginning 0) (match-end 0) 'invisible visibility)))))

;;;###autoload
(define-minor-mode org-hide-heading-stars-mode
  "Hide/show babel source code blocks on demand."
  :global nil :lighter " Org-hhs"
  (unless (derived-mode-p 'org-mode)
    (error "Not in org-mode"))
  (cond (org-hide-heading-stars-mode
         (org-hide-heading-stars--update-headings t))
        (t (font-lock-ensure)
           (org-hide-heading-stars--update-headings nil))))

(provide 'org-hide-heading-stars)

;;; org-hide-heading-stars.el ends here
