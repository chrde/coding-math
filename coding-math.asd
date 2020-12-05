(defsystem "coding-math"
  :version "0.1.0"
  :description ""
  :author ""
  :depends-on (#:sketch)
  :serial t
  :components ((:file "package")
               (:module "src"
                :serial t
                :components ((:file "utils")
                             (:file "vector")
                             (:file "particle")
                             (:file "main")
                             )))
  :description "")
