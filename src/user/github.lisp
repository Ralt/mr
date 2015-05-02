(in-package #:mr.user)


(defun login-github ()
  (h:start-session)
  (let ((state (mr.github:oauth-generate-state)))
    (setf (h:session-value 'github-oauth-state) state)
    (h:redirect (mr.github:oauth-authorize-url state))))

(defun login-github-authorized (code state)
  (unless (mr.github:oauth-validate-state (h:session-value 'github-oauth-state)
                                          state)
    (setf (h:return-code*) h:+http-bad-request+)
    (return-from login-github-authorized))
  (h:delete-session-value 'github-oauth-state)
  (setf (h:session-value 'github-access-token) (mr.github:oauth-access-token code))
  (login-user)
  (h:redirect "/"))
