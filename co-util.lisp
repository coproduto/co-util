(defpackage :co-util
  (:use :cl)
  (:export :ls :cd :pwd))

(in-package :co-util)

(defun expand-path-string (path-string)
  (if (string= path-string "~")
      (make-pathname :directory '(:absolute :home))
      (truename path-string)))

(defun ls ()
  (directory "*.*"))

(defun cd (path-string)
  (let
      ((full-path (expand-path-string path-string)))
    (progn
      (setq common-lisp:*default-pathname-defaults* full-path)
      (sb-posix:chdir full-path)
      full-path)))

(defun pwd ()
  (pathname (sb-posix:getcwd)))
