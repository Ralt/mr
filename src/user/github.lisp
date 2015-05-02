(in-package #:mr.user)


(defvar *github-access-token-url* "https://github.com/login/oauth/access_token")
(defvar *github-client-id* "foo")
(defvar *github-client-secret* "bar")

(defun github-authorize-url (state)
  (concatenate 'string
               "https://github.com/login/oauth/authorize"
               "?client_id=" (github-oauth-get-client-id)
               "&scope=repo"
               "&state=" state))

(defun github-oauth-get-client-id ()
  (or (uiop:getenv "GITHUB_CLIENT_ID")
      *github-client-id*))

(defun github-oauth-get-client-secret ()
  (or (uiop:getenv "GITHUB_CLIENT_SECRET")
      *github-client-secret*))

(defun github-oauth-access-token (code)
  (jsown:val
   (jsown:parse
    (flexi-streams:octets-to-string
     (drakma:http-request
      *github-access-token-url*
      :method :post
      :accept "application/json"
      :parameters (list
                   (list* "code" code)
                   (list* "client_id" (github-oauth-get-client-id))
                   (list* "client_secret" (github-oauth-get-client-secret))))
     :external-format :utf-8))
   "access_token"))
