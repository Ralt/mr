(in-package #:mr.run)


;;;; db version
(defvar *version* 1)
(defvar *debug* t)

(defun db-init ()
  (setf mr:*db-name* (uiop:getenv "DBNAME"))
  (setf mr:*db-user* (uiop:getenv "DBUSER"))
  (setf mr:*db-pass* (uiop:getenv "DBPASS"))
  (setf mr:*db-host* (uiop:getenv "DBHOST"))
  (setf mr:*db-port* (parse-integer (or (uiop:getenv "DBPORT") "5432")))
  (let ((db-version (mr:db-version)))
    (when (= db-version 0)
      (return-from db-init (mr:db-initialize)))
    (when (= *version* db-version)
      (return-from db-init (format t "Database version up-to-date.~%")))
    (when (> *version* db-version)
      (return-from db-init (mr:db-upgrade db-version *version*)))
    (when (< *version* db-version)
      (format t "Database version more recent than code version. Terminating.~%")
      (unless *debug*
        (uiop:quit -1)))))

(defun main (&rest args)
  (declare (ignore args))
  (db-init)
  (mr:hunchentoot-start (parse-integer (or (uiop:getenv "PORT") "4242")) (uiop:getenv "ADDRESS"))
  (when *debug*
    (setf h:*show-lisp-errors-p* t)
    (setf h:*show-lisp-backtraces-p* t)
    (mr:swank-start (parse-integer (or (uiop:getenv "SWANKPORT") "4005"))))
  ;; hack.
  ;; What's shown in http://stackoverflow.com/a/25811271/851498 doesn't work.
  ;; 987654321 seconds is still 31 years anyway.
  (sleep 987654321))
