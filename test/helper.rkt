#lang racket/base

(require rackunit)
(require "../schema/schema.rkt")

(provide cleanup)

(define (cleanup client classname)
  (define resp (delete-class client classname))
  (define status-code (hash-ref resp 'status-code))
  (check-equal? status-code 200))
