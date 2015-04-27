(asdf:defsystem #:mr
  :description "Microservice Reviews"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on (:hunchentoot :postmodern :alexandria :cl-ppcre)
  :components ((:module "src"
                        :components
                        ((:file "package")
                         (:file "db")
                         (:file "routes")
                         (:file "mr")))))
