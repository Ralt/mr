(in-package #:mr.github)


(defun user-login (access-token)
  (j:val (request "/user" access-token)
         "login"))
