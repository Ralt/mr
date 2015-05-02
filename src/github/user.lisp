(in-package #:mr.github)


(defun user-full-name (access-token)
  (jsown:val (request "/user" access-token)
             "login"))
