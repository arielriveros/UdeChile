#lang play
(require "T1.rkt")
(require math/flonum)

(print-only-errors #t)

(define test1
  (simple 10))
(define test2
  (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))
(define test3
  (compound 1 1 (simple 5)))
(define test4
  (compound 0 1 (compound 0 1 (compound 0 1 (simple 1)))))


;;Tests para eval
(test (eval test1) 10)
(test (eval test2) 649/200)
(test (eval test3) 1.2)
(test (eval test4) 1)
;;Tests para degree
(test (degree test1) 0)
(test (degree test2) 3)
(test (degree test3) 1)
(test (degree test4) 3)
;;Tests para eval2
(test (eval2 test1) 10)
(test (eval2 test2) 649/200)
(test (eval2 test3) 1.2)
(test (eval2 test4) 1)
;;Tests para degree2
(test (degree2 test1) 0)
(test (degree2 test2) 3)
(test (degree2 test3) 1)
(test (degree2 test4) 3)
;;Tests para mysterious-cf
(test/exn (mysterious-cf -1) "Error:argumento negativo")
(test (mysterious-cf 0) (simple 3))
(test (mysterious-cf 1) (compound 3 1 (simple 6)))
(test (mysterious-cf 2) (compound 3 1 (compound 6 9 (simple 6))))
(test (mysterious-cf 3) (compound 3 1 (compound 6 9 (compound 6 25 (simple 6)))))
(test (mysterious-cf 4) (compound 3 1 (compound 6 9 (compound 6 25 (compound 6 49 (simple 6))))))
(test (mysterious-cf 5) (compound 3 1 (compound 6 9 (compound 6 25
                             (compound 6 49 (compound 6 81 (simple 6)))))))
(test (mysterious-cf 6) (compound 3 1 (compound 6 9 (compound 6 25
                             (compound 6 49 (compound 6 81 (compound 6 121 (simple 6))))))))
;;Tests para from-to
(test (from-to 0 0) '(0))
(test (from-to 0 1) '(0 1))
(test (from-to 1 4) '(1 2 3 4))
(test (from-to 0 5) '(0 1 2 3 4 5))
;;Tests para mysterious-list
(test (mysterious-list 0) '(3.0))
(test (mysterious-list 1) '(3.0 3.1666666666666665))
(test (mysterious-list 10) '(3.0 3.1666666666666665 3.1333333333333333 3.145238095238095 3.1396825396825396 3.1427128427128426 3.1408813408813407 3.142071817071817 3.1412548236077646 3.141839618929402 3.1414067184965018))
;; Para racket un irracional es igual a un racional en un test siempre y cuando su diferencia tenga precisión menor a 1e-3
(test (fl (eval(mysterious-cf 100))) pi)
(test (fl (eval(mysterious-cf 1000))) pi)
;;Tests para rac-to-cf
(test (rac-to-cf 0) (simple 0))
(test (rac-to-cf 1) (simple 1))
(test (rac-to-cf (+ 1 1/2)) (compound 1 1 (simple 2)))
(test (rac-to-cf 649/200) (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))
(test (rac-to-cf 16568432/654531) (compound 25 1 (compound 3 1 (compound 5 1
                                       (compound 3 1 (compound 1 1 (compound 25 1 (compound 1 1
                                            (compound 3 1 (compound 1 1 (compound 1 1 (compound 1 1
                                                 (compound 12 1 (simple 2))))))))))))))