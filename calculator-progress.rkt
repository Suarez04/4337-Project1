#lang racket

(provide evaluate)

;; Each parser returns (list value remaining-characters).
(define (skip-spaces chars)
  (if (and (pair? chars) (char-whitespace? (car chars)))
      (skip-spaces (cdr chars))
      chars))

(define (invalid)
  (error 'calculator "Invalid expression"))

;; Operators and whitespace mark the end of a number.
(define (number-end? ch)
  (or (char-whitespace? ch) (member ch '(#\+ #\* #\/ #\- #\$))))

(define (parse-number chars)
  (define (collect rest digits)
    (if (or (null? rest) (number-end? (car rest)))
        (let ([value (string->number (list->string (reverse digits)))])
          (if (and (real? value) (rational? value))
              (list value rest)
              (invalid)))
        (collect (cdr rest) (cons (car rest) digits))))
  (collect chars '()))

(define (parse-history chars history)
  (define (collect rest digits)
    (if (and (pair? rest) (char-numeric? (car rest)))
        (collect (cdr rest) (cons (car rest) digits))
        (let ([id (string->number (list->string (reverse digits)))])
          (if (and (exact-positive-integer? id) (<= id (length history)))
              (list (list-ref (reverse history) (sub1 id)) rest)
              (invalid)))))
  (collect chars '()))

(define (parse-expression chars history)
  (define rest (skip-spaces chars))
  (if (null? rest)
      (invalid)
      (let ([ch (car rest)])
        (cond
          [(char=? ch #\$) (parse-history (cdr rest) history)]
          [(char=? ch #\-)
           (define result (parse-expression (cdr rest) history))
           (list (- (first result)) (second result))]
          [(member ch '(#\+ #\* #\/))
           (define left (parse-expression (cdr rest) history))
           (define right (parse-expression (second left) history))
           (define a (first left))
           (define b (first right))
           (define value
             (cond
               [(char=? ch #\+) (+ a b)]
               [(char=? ch #\*) (* a b)]
               [(zero? b) (invalid)]
               [else (/ a b)]))
           (list value (second right))]
          [else (parse-number rest)]))))

(define (evaluate text history)
  (define result (parse-expression (string->list text) history))
  (unless (null? (skip-spaces (second result)))
    (error 'calculator "Unexpected trailing characters"))
  (first result))

(define prompt?
  (let ([args (current-command-line-arguments)])
    (cond
      [(= (vector-length args) 0) #t]
      [(string=? (vector-ref args 0) "-b") #f]
      [(string=? (vector-ref args 0) "--batch") #f]
      [else #t])))

;; Return the old history when an expression fails.
(define (process-line line history)
  (with-handlers ([exn:fail? (lambda (exn)
                               (displayln "Error: Invalid expression")
                               history)])
    (define value (evaluate line history))
    (define new-history (cons value history))
    (display (length new-history))
    (display ": ")
    (display (real->double-flonum value))
    (newline)
    new-history))

(define (eval-loop history)
  (when prompt?
    (display "Enter expression (quit to exit): ")
    (flush-output))
  (define line (read-line))
  (unless (or (eof-object? line) (string=? line "quit"))
    (eval-loop (process-line line history))))

(module+ main
  (eval-loop '()))
