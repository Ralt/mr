(in-package #:mr.github)


(defun user-full-name (access-token)
  (j:val (request "/user" access-token)
         "login"))
