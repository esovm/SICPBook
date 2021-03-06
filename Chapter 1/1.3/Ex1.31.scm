#lang planet neil/sicp

(define (inc n) (+ n 1))
(define (identity x) x)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (factorial n)  
  (product identity 1 inc n))

(factorial 5)

;; ITERATIVE Version - factorial function is same and can be simplified by passing in function (iter vs recursive)
;; to use
(define (factorial-iter n)
  (product-iter identity 1 inc n))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(factorial-iter 5)

;; WALLIS PRODUCT
;; Formula for pi / 2 using wallis product is 4n^2 / 4n^2 - 1
;; http://en.wikipedia.org/wiki/Wallis_product

(define (square n) (* n n))

(define (wallis-pi n)
  (define (term n)
    (/ (* 4 (square n)) (- (* 4 (square n)) 1)))
  (* 2 (product-iter term 1 inc n)))

(wallis-pi 10)

;; Formula for nth term in book
(define (wallis-pi2 n)
  (define (term n)
    (if (even? n)
        (/ (+ 2 n) (+ 1 n))
        (/ (+ 1 n) (+ 2 n))))
  (* 4 (product-iter term 1 inc n)))

(wallis-pi2 10)

(= (wallis-pi 100000) (wallis-pi2 100000))