(in-package #:mr.user)


(setf ironclad:*prng* (ironclad:make-prng :fortuna))

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
  (h:delete-session-value 'github-oauth-state)
  (setf (h:session-value 'github-access-token) (github-oauth-access-token code))
  (h:redirect "/"))
