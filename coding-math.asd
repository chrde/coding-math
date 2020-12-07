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
                                     (:file "episode-11")
                                     (:file "episode-12")
                                     (:file "ballistics")
                                     (:file "mini-2")
                                     (:file "mini-3")
                                     (:file "mini-4")
                                     (:file "main")
                                     )))
  :description "")
