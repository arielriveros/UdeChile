;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               TESTS - TAREA 2                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang play
(require "P3.rkt")
(print-only-errors #t)

;; Test parse
(test (parse 5) (real 5))
(test (parse '(+ 1 1)) (add (real 1) (real 1)))
(test (parse '(+ 1 (1)i)) (comp 1 1))
(test (parse 'x) (id 'x))
(test (parse '(fun (x) (+ 2 x))) (fun 'x (add (real 2) (id 'x))))
(test (parse '(f (+ 2 3))) (app (id 'f) (add (real 2) (real 3))))
(test (parse '((+ y 5) where y = (+ 2 4))) (app (fun 'y (add (id 'y) (real 5))) (add (real 2) (real 4))))
;; Test sum+
(test (num+ (realV 1) (realV 2)) (realV 3))
(test (num+ (realV 1) (compV 2 3)) (compV 3 3))
(test (num+ (compV 0 5) (realV 3)) (compV 3 5))
(test (num+ (compV 2 3) (compV -1 -2)) (compV 1 1))
;; Test run
(test (run ' (( f (+ 2 (+ 1 (2)i))) where f = (fun (x) (+ x x)))) (compV 6 4))
(test (run ' (( g (+ (+ 10 (10)i) (+ 1 (2)i))) where g = (fun (x) (+ x (+ x x))))) (compV 33 36))