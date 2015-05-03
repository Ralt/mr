(in-package #:mr)


;;; Taken from http://stackoverflow.com/a/26440069/851498
(defmacro method-path (methods path)
  "Expands to a predicate the returns true of the Hunchtoot request
has a SCRIPT-NAME matching the PATH and METHOD in the list of METHODS.
You may pass a single method as a designator for the list containing
only that method."
  (declare
   (type (or keyword list) methods)
   (type string path))
  `(lambda (request)
     (and (member (hunchentoot:request-method* request)
                 ,(if (keywordp methods)
                      `'(,methods)
                      `',methods))
          (string= (hunchentoot:script-name* request)
                   ,path))))

;;;; hunchentoot basic handling
(defvar *hunchentoot-server* nil)

(defun hunchentoot-start (&optional (port 4242) (address "localhost"))
  (setf *hunchentoot-server*
        (h:start
         (make-instance
          'h:easy-acceptor :port port :address address
          :document-root (or
                          (uiop:getenv "DOCUMENT_ROOT")
                          (merge-pathnames
                           #p"public/"
                           (asdf:system-source-directory :mr)))))))

(defun hunchentoot-stop (&optional (soft t))
  (h:stop *hunchentoot-server* :soft soft))
