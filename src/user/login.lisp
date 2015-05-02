(in-package #:mr.user)


(defparameter +login.html+ (djula:compile-template* "login.html"))

(defvar *github-access-token-url* "https://github.com/login/oauth/access_token")

(setf ironclad:*prng* (ironclad:make-prng :fortuna))

(defun github-authorize-url ()
  (let ((state (ironclad:byte-array-to-hex-string
                (ironclad:random-data 32))))
    (setf (h:session-value 'github-oauth-state) state)
    (concatenate 'string
                 "https://github.com/login/oauth/authorize"
                 "?client_id=" *github-oauth-client-id*
                 "&redirect_uri=" (absolute-url "/user/login/github/authorized")
                 "&scope=repo"
                 "&state=" state)))

(defun absolute-url (path)
  (concatenate 'string
               (string-downcase (symbol-name (h:server-protocol*)))
               "://"
               (h:host)
               path))

(defun login ()
  (djula:render-template* +login.html+))

(defun login-github ()
  (h:start-session)
  (h:redirect (github-authorize-url)))

(defun login-github-authorized (state code)
  (unless (string= (h:session-value 'github-oauth-state)
                   state)
    (setf (h:return-code*) h:+http-bad-request+)
    (return-from login-github-authorized))
  (h:delete-session-value 'github-oauth-state) ; no longer needed
  (let ((response (jsown:parse
                   (drakma:http-request
                    *github-access-token-url*
                    :method :post
                    :accept "application/json"
                    :parameters (list
                                 (list* "code" code)
                                 (list* "client_id" (github-oauth-get-client-id))
                                 (list* "client_secret" (github-oauth-get-client-secret)))))))
    (setf (h:session-value 'github-access-token) (jsown:val response "access_token"))
    (h:redirect "/")))

(defun github-oauth-get-client-id ()
  (or (uiop:getenv "GITHUB_CLIENT_ID")
      "foo"))

(defun github-oauth-get-client-secret ()
  (or (uiop:getenv "GITHUB_CLIENT_SECRET")
      "bar"))

(defun logout ()
  (h:remove-session)
  (h:redirect "/user/login"))
