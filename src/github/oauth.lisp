(in-package #:mr.github)


(defvar *oauth-access-token-url* "https://github.com/login/oauth/access_token")
(defvar *oauth-client-id* "foo")
(defvar *oauth-client-secret* "bar")

(defun oauth-authorize-url (state)
  (concatenate 'string
               "https://github.com/login/oauth/authorize"
               "?client_id=" (oauth-get-client-id)
               "&scope=repo"
               "&state=" state))

(defun oauth-get-client-id ()
  (or (uiop:getenv "GITHUB_CLIENT_ID")
      *oauth-client-id*))

(defun oauth-get-client-secret ()
  (or (uiop:getenv "GITHUB_CLIENT_SECRET")
      *oauth-client-secret*))

(defun oauth-access-token (code)
  (jsown:val
   (jsown:parse
    (flexi-streams:octets-to-string
     (drakma:http-request
      *oauth-access-token-url*
      :method :post
      :accept "application/json"
      :parameters (list
                   (list* "code" code)
                   (list* "client_id" (oauth-get-client-id))
                   (list* "client_secret" (oauth-get-client-secret))))
     :external-format :utf-8))
   "access_token"))
