(in-package #:mr)


(defun swank-start (port)
  (setf swank::*loopback-interface* "0.0.0.0")
  (swank-loader:init)
  (swank:create-server :port port
                       :style swank:*communication-style*
                       :dont-close t))
