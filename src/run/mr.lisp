(in-package #:mr)


;;;; db version
(defvar *version* 1)
(defvar *debug* t)

(defun db-init ()
  (setf *db-name* (uiop:getenv "DBNAME"))
  (setf *db-user* (uiop:getenv "DBUSER"))
  (setf *db-pass* (uiop:getenv "DBPASS"))
  (setf *db-host* (uiop:getenv "DBHOST"))
  (setf *db-port* (parse-integer (or (uiop:getenv "DBPORT") "5432")))
  (let ((db-version (db-version)))
    (when (= db-version 0)
      (return-from db-init (db-initialize)))
    (when (= *version* db-version)
      (return-from db-init (format t "Database version up-to-date.~%")))
    (when (> *version* db-version)
      (return-from db-init (db-upgrade db-version *version*)))
    (when (< *version* db-version)
      (format t "Database version more recent than code version. Terminating.~%")
      (unless *debug*
        (uiop:quit -1)))))

(defun start-swank (port)
  (setf swank::*loopback-interface* "0.0.0.0")
  (swank-loader:init)
  (swank:create-server :port port
                       :style swank:*communication-style*
                       :dont-close t))

(defun main (&rest args)
  (declare (ignore args))
  (db-init)
  (start (parse-integer (or (uiop:getenv "PORT") "4242")) (uiop:getenv "ADDRESS"))
  (when *debug*
    (start-swank (parse-integer (or (uiop:getenv "SWANKPORT") "4005"))))
  ;; hack.
  ;; What's shown in http://stackoverflow.com/a/25811271/851498 doesn't work.
  ;; 987654321 seconds is still 31 years anyway.
  (sleep 987654321))
