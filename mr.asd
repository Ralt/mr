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
                        ((:file "packages")
                         (:file "db")
                         (:file "hunchentoot")
                         (:file "swank")
                         (:file "templates")))
               (:module "src/github"
                        :components
                        ((:file "request")
                         (:file "oauth")
                         (:file "user")))
               (:module "src/user"
                        :components
                        ((:file "db")
                         (:file "github")
                         (:file "login")))
               (:module "src/review"
                        :components
                        ((:file "db")
                         (:file "list")))
               (:module "src/run"
                        :components
                        ((:file "routes")
                         (:file "mr")))))
