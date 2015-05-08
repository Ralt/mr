(defpackage #:mr
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern)
                    (#:a #:alexandria))
  (:export :with-db
           :db-version
           :db-upgrade
           :db-initialize
           :*db-name*
           :*db-user*
           :*db-pass*
           :*db-host*
           :*db-port*
           :hunchentoot-start
           :hunchentoot-stop
           :swank-start
           :method-path))

(defpackage #:mr.github
  (:use #:cl)
  (:local-nicknames (#:d #:drakma)
                    (#:f #:flexi-streams)
                    (#:j #:jsown))
  (:export :user-login
           :oauth-authorize-url
           :oauth-generate-state
           :oauth-validate-state
           :oauth-access-token))

(defpackage #:mr.user
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern))
  (:export :login
           :login-github
           :login-github-authorized
           :logout
           :id))

(defpackage #:mr.review
  (:use #:cl)
  (:local-nicknames (#:pm #:postmodern))
  (:export :list-reviews
           :get-one))

(defpackage #:mr.run
  (:use #:cl)
  (:local-nicknames (#:h #:hunchentoot)
                    (#:pm #:postmodern)
                    (#:a #:alexandria))
  (:export :main))
