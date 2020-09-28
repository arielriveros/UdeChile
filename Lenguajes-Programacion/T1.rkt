#lang play
(require math/flonum)

#|
Complete sus datos personales:
NOMBRE Y APELLIDO: Ariel Riveros
RUT: 19.528.980-8
|#

;; Parte a)

#|
<CFraction> ::= (simple <value>)
             |  (compound <value> <value> <CFraction>)
|#
(deftype CFraction
  (simple num)
  (compound num1 num2 comp))

;; Parte b)
;; eval :: CFraction -> Rational
;; evalua una fraccion continua a su valor racional representativo
(define (eval cFrac)
  (match cFrac
   [(simple n) n]
   [(compound n1 n2 c) (+ n1 (/ n2 (eval c)))]
;;   [(compound n1 n2 c) (lambda (x) (+ n1 (/ n2 (eval x)))) c]
    )
 )


;; Parte c)
;; degree ::  CFraction -> Integer
;; entrega el grado de la fraccion continua
(define (degree cFrac)
  (match cFrac
    [(simple _) 0]
    [(compound _ _ c) (+ 1 (degree c))]
    )
  )


;; Parte d)
;; fold :: (Integer -> A) (Integer Integer A -> A) -> (CFraction -> A)
(define (fold f g)
  (lambda (cFrac)
    (match cFrac
      [(simple num) (f num)]
      [(compound n1 n2 c) (g n1 n2 ((fold f g) c))]
      )
    )
  )


;; Parte e)
;; eval2 :: CFraction -> Rational
(define eval2
  (fold identity (lambda (n1 n2 x) (+ n1 (/ n2 x)))))

;; degree2 ::  CFraction -> Integer
(define degree2
  (fold (lambda (x) (* x 0)) (lambda (n1 n2 x) (+ x 1)))
  )

(define test1
  (simple 10))

(define test2
  (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))

(define test3
  (compound 1 1 (simple 5)))


;; Parte f)
;; mysterious-cf :: Integer -> CFraction



;; Parte g)
;; from-to :: Integer -> Integer -> listOf Integer

;; mysterious-list :: Integer -> listOf Float

;; A que numero tiende (mysterious-cf k) cuando k tiende a infinito?



;; Parte h)
;; rac-to-cf :: Rational -> CFraction


