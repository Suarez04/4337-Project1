#lang racket
(require "calculator.rkt")

(define passed 0)

(define (check text history expected)
  (define actual (evaluate text history))
  (unless (= actual expected)
    (error 'test "~s: expected ~a, got ~a" text expected actual))
  (set! passed (add1 passed)))

(define (check-error text history)
  (define failed?
    (with-handlers ([exn:fail? (lambda (exn) #t)])
      (evaluate text history)
      #f))
  (unless failed?
    (error 'test "Expected error for ~s" text))
  (set! passed (add1 passed)))

(check "*+ 1 1 /4 2" '() 4)
(check "/5$1" '(2) 5/2)
(check "+++/5$1-2*-$1-5 9" '(2) 39/2)
(check "+ *2$1+$2 1" '(20 5) 31)
(check "- - 3" '() 3)
(check "+1-1" '() 0)
(check " + 1.5 2.25  " '() 3.75)
(check "$1" '(30 20 10) 10)
(check "$3" '(30 20 10) 30)
(check "\t* 6\t7 " '() 42)
(for ([text '("" " " "+1" "+1 2 2" "/5 0" "$0" "$-1" "$1"
              "$1.5" "$" "abc" "+ 1 x" "1abc" "( + 1 2 )"
              "quit" "-" "*" "/0 0" "+nan.0" "1+2")])
  (check-error text '()))
(check-error "$4" '(30 20 10))
(check-error "$1.5" '(10))
(displayln (format "Passed ~a evaluator checks." passed))
