#lang racket

(define (func n)
  (cond
    [(= n 0) (λ(x) (* x 11))]
    [(= n 1) (λ(x) (+ x 4))]
    [(= n 2) (λ(x) (* x 19))]
    [(= n 3) (λ(x) (* x x))]
    [(= n 4) (λ(x) (+ x 1))]
    [(= n 5) (λ(x) (+ x 3))]
    [(= n 6) (λ(x) (+ x 8))]
    [(= n 7) (λ(x) (+ x 7))]
))

(define (calcValue monkey value)
  ((func monkey) value)
)

(define ans (build-list 8 (lambda (x) 0)))

(define (test n)
  (cond
    [(= n 0) (λ(x) (if (= (modulo x 5) 0) 7 4))]
    [(= n 1) (λ(x) (if (= (modulo x 2) 0) 2 6))]
    [(= n 2) (λ(x) (if (= (modulo x 13) 0) 5 0))]
    [(= n 3) (λ(x) (if (= (modulo x 7) 0) 6 1))]
    [(= n 4) (λ(x) (if (= (modulo x 19) 0) 3 7))]
    [(= n 5) (λ(x) (if (= (modulo x 11) 0) 0 4))]
    [(= n 6) (λ(x) (if (= (modulo x 3) 0) 5 2))]
    [(= n 7) (λ(x) (if (= (modulo x 17) 0) 3 1))]
))

(define (cycle turn monkey value)
  (begin
    (set! ans (list-set ans monkey (add1 (list-ref ans monkey))))
    (define newValue (calcValue monkey value))
    (define nextValue (if (> newValue 9699690) (modulo newValue 9699690) newValue))
    (define newMonkey ((test monkey) newValue))
    (define newTurn (if (< monkey newMonkey) turn (add1 turn)))
    (cond
      ;[(= newTurn 21) #t]   --> for part 1
      [(= newTurn 10001) #t]
      [else (cycle newTurn newMonkey nextValue)]))
)

(map (lambda (i) (cycle 1 0 i)) (list 61))
(map (lambda (i) (cycle 1 1 i)) (list 76 92 53 93 79 86 81))
(map (lambda (i) (cycle 1 2 i)) (list 91 99))
(map (lambda (i) (cycle 1 3 i)) (list 58 67 66))
(map (lambda (i) (cycle 1 4 i)) (list 94 54 62 73))
(map (lambda (i) (cycle 1 5 i)) (list 59 95 51 58 58))
(map (lambda (i) (cycle 1 6 i)) (list 87 69 92 56 91 93 88 73))
(map (lambda (i) (cycle 1 7 i)) (list 71 57 86 67 96 95))

(displayln ans)
