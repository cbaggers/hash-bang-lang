;;;; hash-bang-lang.asd

(asdf:defsystem #:hash-bang-lang
  :description "Reader macro to aid making languages in lisp"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:named-readtables)
  :components ((:file "package")
               (:file "hash-bang-lang")))
