(asdf:defsystem #:mr
  :description "Microservice Reviews"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on (:hunchentoot :postmodern :alexandria :cl-ppcre :swank :djula)
  :components ((:module "src/user"
                        :components
                        ((:file "package")
                         (:file "login")))
               (:module "src"
                        :components
                        ((:file "package")
                         (:file "db")
                         (:file "hunchentoot")
                         (:file "routes")
                         (:file "mr")))))
