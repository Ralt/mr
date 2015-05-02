(asdf:defsystem #:mr
  :description "Microservice Reviews"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on (:hunchentoot
               :postmodern
               :alexandria
               :cl-ppcre
               :swank
               :djula
               :ironclad
               :drakma
               :jsown
               :flexi-streams)
  :components ((:module "src"
                        :components
                        ((:file "package")
                         (:file "db")
                         (:file "hunchentoot")
                         (:file "templates")))
               (:module "src/user"
                        :components
                        ((:file "package")
                         (:file "login")))
               (:module "src/run"
                        :components
                        ((:file "package")
                         (:file "routes")
                         (:file "mr")))))
