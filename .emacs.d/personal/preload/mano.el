;;; mano.el -- useful macros and functions made by me, Manoel

;; Copyright © 2017 Manoel Vilela
;;
;; Author: Manoel Vilela <manoel_vilela@engineer.com>
;; URL: https://github.com/ryukinix/dotfiles
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; I'm trying organize my utils functions.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defmacro try-quote (symbol)
  "Quote the SYMBOL if is not quoted.
SYMBOL is any datum."
  (or (and (consp symbol)
           (eq (car symbol) 'quote)
           symbol)
      `(quote ,symbol)))

(defmacro when-system (system &rest body)
  "Only eval BODY when SYSTEM is the name/alias of the running system.
SYSTEM can be a unquoted symbol designing a `system-type'
or one of its alias: linux, windows and mac-os.
BODY is the rest of eval forms to be executed when SYSTEM is equal
to `system-type'."
  (let ((system-alist (make-symbol "system-alist"))
        (system-symbol (make-symbol "system-symbol"))
        (quoted-system (make-symbol "quoted-system")))
    `(let* ((,system-alist '((linux gnu/linux)
                             (mac-os darwin)
                             (windows windows-nt)))
            (,quoted-system (try-quote ,system))
            (,system-symbol (or (second (assoc ,quoted-system ,system-alist))
                              ,quoted-system)))
       (when (eq system-type ,system-symbol)
         ,@body))))


(defmacro memoize (func &rest body)
  "Create a lexical cache for the given FUNC.
FUNC must be a pure function of only one parameter.
BODY is the rest of eval forms to be used FUNC memoized."
  `(let ((table (make-hash-table))
         (old-func (symbol-function ',func)))
     (labels ((,func (x)
                     (if (not (null (nth-value 1 (gethash x table))))
                         (gethash x table)
                       (setf (gethash x table)
                             (funcall old-func x)))))
       (setf (symbol-function ',func) #',func)
       (prog1 ,@body
         (setf (symbol-function ',func) old-func)))))

(defun tab-mode ()
  "Toggle `indent-tabs-mode'."
  (interactive)
  (progn (setq-local indent-tabs-mode (not indent-tabs-mode))
         (message "%s" indent-tabs-mode))
  (if indent-tabs-mode
      (setq-local backward-delete-char-untabify-method 'hungry)
    (setq-local backward-delete-char-untabify-method 'untabify)))

;;;###autoload
(defun lerax-c-reformat-region (&optional b e)
  "Format the region selected with clang-format -style=LLVM"
  (interactive "r")
  (when (not (buffer-file-name))
    (error "A buffer must be associated with a file in order to use REFORMAT-REGION."))
  (when (not (executable-find "clang-format"))
    (error "clang-format not found."))
  (shell-command-on-region b e
                           "clang-format -style=LLVM"
                           (current-buffer) t)
  (indent-region b e))

(provide 'manoel)
;;; mano.el ends here
