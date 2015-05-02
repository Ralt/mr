(in-package #:mr.user)


(defparameter +login.html+ (djula:compile-template* "login.html"))

(defvar *github-access-token-url* "https://github.com/login/oauth/access_token")

(setf ironclad:*prng* (ironclad:make-prng :fortuna))

(defun github-authorize-url (state)
  (concatenate 'string
               "https://github.com/login/oauth/authorize"
               "?client_id=" (github-oauth-get-client-id)
               "&redirect_uri=" (absolute-url "/user/login/github/authorized")
               "&scope=repo"
               "&state=" state))

(defun absolute-url (path)
  (concatenate 'string
               "http://"
               (h:host)
               path))

(defun login ()
  (djula:render-template* +login.html+))

(defun login-github ()
  (h:start-session)
  (let ((state (ironclad:byte-array-to-hex-string
                (ironclad:random-data 32))))
    (setf (h:session-value 'github-oauth-state) state)
    (h:redirect (github-authorize-url state))))

(defun login-github-authorized (code state)
  (unless (string= (h:session-value 'github-oauth-state)
                   state)
    (setf (h:return-code*) h:+http-bad-request+)
    (return-from login-github-authorized))
  (h:delete-session-value 'github-oauth-state) ; no longer needed
  (let ((response (jsown:parse
                   (flexi-streams:octets-to-string
                    (drakma:http-request
                     *github-access-token-url*
                     :method :post
                     :accept "application/json"
                     :parameters (list
                                  (list* "code" code)
                                  (list* "client_id" (github-oauth-get-client-id))
                                  (list* "client_secret" (github-oauth-get-client-secret))))
                    :external-format :utf-8))))
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
