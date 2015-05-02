(defpackage #:mr.github
  (:use #:cl)
  (:local-nicknames (#:d #:drakma)
                    (#:f #:flexi-streams)
                    (#:j #:jsown))
  (:export :user-full-name
           :oauth-authorize-url
           :oauth-access-token))
