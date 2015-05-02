(defpackage #:mr.github
  (:use #:cl)
  (:local-nicknames (#:d #:drakma))
  (:export :user-full-name
           :oauth-authorize-url
           :oauth-access-token))
