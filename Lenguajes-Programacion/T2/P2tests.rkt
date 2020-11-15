;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               TESTS - TAREA 2                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang play
(require "P2.rkt")
(print-only-errors #t)

;;Test para parse
(test (parse 'True) (bool #t))
(test (parse 'False) (bool #f))
(test (parse '(A v False)) (bor (id 'A) (bool #f)))
(test (parse '(C ^ (A v B))) (band (id 'C) (bor (id 'A) (id 'B))))
(test (parse '(C ^ (A v B))) (band (id 'C) (bor (id 'A) (id 'B))))
;;tests para interp
(test (interp (parse 'True) empty-env) (BoolV #t))
(test/exn (interp (parse ' (A ^ False)) empty-env) " Identificador A no definido")
(test/exn (interp (parse ' (C ^ (A v B))) empty-env) " Identificador B no definido")
