#lang play
(require math/flonum)

#|
Complete sus datos personales:
NOMBRE Y APELLIDO: Ariel Riveros
RUT: 19.528.980-8
|#

;; Parte a)

#|
<CFraction> ::= (simple <num>)
             |  (compound <num> <num> <CFraction>)
|#
(deftype CFraction
  (simple num)
  (compound num1 num2 comp))

(define ejemplo
  (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))

;; Parte b)
;; eval :: CFraction -> Rational
;; evalua una fraccion continua a su valor racional representativo
(define (eval cFrac)
  (match cFrac
   [(simple n) n]
   [(compound n1 n2 c) (+ n1 (/ n2 (eval c)))]
    )
 )


;; Parte c)
;; degree ::  CFraction -> Integer
;; entrega el grado de la fraccion continua
(define (degree cFrac)
  (match cFrac
    [(simple n) 0]
    [(compound n1 n2 c) (+ 1 (degree c))]
    )
  )


;; Parte d)
;; fold :: (Integer -> A) (Integer Integer A -> A) -> (CFraction -> A)
(define (fold f g)
  (lambda (cFrac)
    (match cFrac
      [(simple num) (f num)]
      [(compound n1 n2 c) (g n1 n2 ((fold f g) c))])
    )
  )


;; Parte e)
;; eval2 :: CFraction -> Rational


;; degree2 ::  CFraction -> Integer




;; Parte f)
;; mysterious-cf :: Integer -> CFraction



;; Parte g)
;; from-to :: Integer -> Integer -> listOf Integer

;; mysterious-list :: Integer -> listOf Float

;; A que numero tiende (mysterious-cf k) cuando k tiende a infinito?



;; Parte h)
;; rac-to-cf :: Rational -> CFraction





