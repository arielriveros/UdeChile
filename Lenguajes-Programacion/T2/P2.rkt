;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 P2 - TAREA 2                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOMBRE APELLIDO: Ariel Riveros
;; Mucho Ã©xito :)

#lang play

#| <logic> ::= 
    | (bool <bool>)
    | (id <id>)
    | (band <logic> <logic>)
    | (bor <logic> <logic>)
    | (with <id> <logic> <logic>)
|#

#| ================================
                PARTE A
   ================================|#

;; Logic representa la sintaxis abstracta que usa el lenguaje

(deftype Logic
  (bool b)
  (id i)
  (band b1 b2)
  (bor b1 b2)
  (with i expr body)
  )

#| ================================
                PARTE B
   ================================ |#

#| <s-expr> ::= <bool>
              | <sym>
              | (list <s-expr> '^ <s-expr>)
              | (list <s-expr> 'v <s-expr>)
              | (list 'with (list <sym> <s-expr>) <s-expr>)
|#


;; parse recupera la sintaxis concreta y la pasa a sintaxis abstracta
;; parse :: s-expr -> logic
(define (parse s-expr)
  (match s-expr
    ['True (bool #t)] ['False (bool #f)]
    [i #:when (symbol? i) (id i)]
    [(list b1 '^ b2) (band (parse b1) (parse b2))]
    [(list b1 'v b2) (bor (parse b1) (parse b2))]
    [(list 'with (list i b) b1) #:when (symbol? i)(with i (parse b) (parse b1))]
    )
  )

#| ================================
                PARTE C 
   ================================ |#

;; LValue representa los valores de las evaluaciones en el lenguaje
(deftype LValue
  (BoolV b)
 )


#| ================================
                PARTE D
   ================================ |#


;; Interfaz del tipo de dato abstracto que
;; representa los ambientes de identificadores.
;; empty-env  :: Env
;; extend-env :: Sym LValue Env -> Env
;; env-lookup :: Sym Env -> LValue

#|
<env> ::= (mtEnv)
        | (aEnv <id> <LValue> <env>)
|#

(deftype Env
  (mtEnv)
  (aEnv id val env)
 )


(define empty-env (mtEnv))

(define extend-env aEnv)

(define (env-lookup x env)
  (match env
    [(aEnv id val rest) (if (symbol=? id x)
                            val
                            (env-lookup x rest)
                            )]
    [(mtEnv) (error 'env-lookup: "Identificador ~a no definido" x)]
    )
  )

;; Interprete del lenguaje
;; interp :: Expr Env -> LValue
(define (interp expr env)
  (match expr
    [(bool b) (BoolV b)]
    [(id i) (env-lookup i env)]
    [(bor  b1 b2) (let ([n1 (interp b2 env)]) (let ([n2 (interp b1 env)]) (or n2 n1)))]
    [(band b1 b2) (let ([n1 (interp b2 env)]) (let ([n2 (interp b1 env)]) (and n2 n1)))] 
    [(with id expr body) (def new-env (extend-env id (interp expr env) env))
                         (interp body new-env)]
   )
 )