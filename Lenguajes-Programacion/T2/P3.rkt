;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 P3 - TAREA 2                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOMBRE APELLIDO: Ariel Riveros
;; Mucho Ã©xito :)

#lang play

#| ================================
                PARTE A
   ================================|#
#|
<expr> ::= ( real <num>)
         | (comp <num> <num>)
         | (add <expr> <expr>)
         | (id <id>)
         | (fun <sym> <expr>)
         | (app <expr> <expr>)
|#


(deftype expr
  (real n)
  (comp n1 n2)
  (add l r)
  (id i)
  (fun s e)
  (app f e)
  )

#| ================================
                PARTE B
   ================================ |#

#|
<s-expr> ::= <num>
           | <sym>
           | (list '+ <num> (list (<num>))i )
           | (list '+ <s-expr> <s-expr>)
           | (list 'fun (list <sym>) <s-expr>)
           | (list <s-expr> <s-expr>)
           | (list <s-expr> 'where <sym> '= <s-expr>)  <- syntactical sugar
|#

;; parse transforma sintaxis concreta a sintaxis abstracta
;; parse :: s-expr -> Expr
(define (parse s-expr)
  (match s-expr
    [n #:when (number? n) (real n)]
    [i #:when (symbol? i) (id i)]
    [(list '+ n1 (list n2)i ) (comp n1 n2)]
    [(list '+ l r) (add (parse l) (parse r))]
    [(list 'fun (list x) body) (fun x (parse body))]
    [(list f body) (app (parse f) (parse body))]
    [(list body 'where i '= exp) #:when (symbol? i) (app (fun i (parse body)) (parse exp))]
   )
 )

#| ================================
                PARTE C
   ================================ |#

;; Values of Expressions
#| <value> ::= <num>
             | <>
|#
(deftype Value
  (realV n)
  (compV n1 n2)
  (closureV id body env)
 )

;; num+ captura numeros de tipo Value y los suma respetando las propiedades
;; de la suma de numeros complejos retornando su resultado en tipo Value
;; num+ :: Value Value -> Value
(define (num+ v1 v2)
  (match (list v1 v2)
    [ (list (realV n) (realV m)) (realV (+ n m))]
    [ (list (realV n) (compV a b)) (compV (+ n a) b)]
    [ (list (compV a b) (compV x y)) (compV (+ a x) (+ b y))]
    [ (list (compV a b) (realV n)) (compV (+ a n) b)]))



#| ================================
                PARTE D
   ================================ |#

;; Interfaz del tipo de dato abstracto que
;; representa los ambientes de identificadores.
;; empty-env  :: Env
;; extend-env :: Symbol Value Env -> Env
;; env-lookup :: Symbol Env -> Value

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
    )
  )

#|
<expr> ::= ( real <num>)
         | (comp <num> <num>)
         | (add <expr> <expr>)
         | (id <id>)
         | (fun <sym> <expr>)
         | (app <expr> <expr>)
|#

;; eval evalua expresiones en sintaxis abstracta en un ambiente
;; para devolverlas como valores tipo Value
;; eval :: Expr Env -> Value
(define (eval expr env)
  (match expr
    [(real n) (compV n 0)]
    [(comp n1 n2) (compV n1 n2)]
    [(add l r) (num+ (eval l env) (eval r env))]
    [(id i) (env-lookup i env)]
    [(fun id exp) (closureV id exp env)]
    [(app f exp) (def (closureV arg body claus) (eval f env))
                 (def ext-env (extend-env arg (eval exp env) claus))
                 (eval body ext-env)]
    )
  )


;; evalua una expresion en sintaxis concreta y retorna el valor resultante en tipo Value
;; run :: s-expr -> Value

(define (run expr)
  (eval (parse expr) empty-env)
 )