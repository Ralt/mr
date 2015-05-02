(defpackage #:mr
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern)
                    (#:a #:alexandria))
  (:export :with-db))

(defpackage #:mr.github
  (:use #:cl)
  (:local-nicknames (#:d #:drakma)
                    (#:f #:flexi-streams)
                    (#:j #:jsown))
  (:export :user-full-name
           :oauth-authorize-url
           :oauth-access-token))

(defpackage #:mr.user
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern))
  (:export :login
           :login-github
           :login-github-authorized
           :logout))

(defpackage #:mr.run
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern)
                    (#:a #:alexandria)))
