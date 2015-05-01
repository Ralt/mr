(defpackage #:mr.user
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern))
  (:export :login
           :login-github))
