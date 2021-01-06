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
                                     (:file "circle")
                                     (:file "rec")
                                     (:file "collision")
                                     ;; episodes
                                     (:file "gravity-sun")
                                     (:file "episode-12")
                                     (:file "episode-13")
                                     (:file "episode-14")
                                     (:file "episode-spring")
                                     (:file "episode-ballistics")
                                     (:file "episode-18")
                                     (:file "episode-19-bezier")
                                     (:file "episode-20-bezier")
                                     (:file "episode-22-postcards3d")
                                     (:file "episode-23-postcards3d")
                                     (:file "mini-2-lerp")
                                     (:file "mini-3-map")
                                     (:file "mini-clamp")
                                     (:file "mini-5-pythagoras")
                                     (:file "mini-6-random")
                                     (:file "mini-8-round")
                                     (:file "mini-9-random-distribution")
                                     (:file "mini-10-random-distribution")
                                     (:file "main")
                                     )))
  :description "")
