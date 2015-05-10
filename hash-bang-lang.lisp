(in-package #:hash-bang-lang)

(defgeneric hash-bang-dispatch (lang-name stream))

(defmethod hash-bang-dispatch ((lang-name t) stream)
  (error "#!lang: No suitable parser found for lang ~a" lang-name))

(defmacro deflang (name (stream-var) &body body)
  (let ((lang-var (gensym (symbol-name name))))
    `(defmethod hash-bang-dispatch ((,lang-var (eql ',name)) ,stream-var)
       (declare (ignore ,lang-var))
       ,@body)))

(defun hash-bang-reader (stream subchar arg)
  (declare (ignore subchar arg))
  (let* ((lang-name (read stream t nil t)))
    (assert (and (symbolp lang-name) (not (keywordp lang-name))))
    (hash-bang-dispatch lang-name stream)))

(named-readtables:defreadtable hash-bang
  (:merge :standard)
  (:dispatch-macro-char #\# #\! #'hash-bang-reader))

;; (named-readtables:in-readtable hash-bang)
