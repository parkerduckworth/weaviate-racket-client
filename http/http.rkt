#lang racket/base

(require json)
(require net/http-easy)

(provide get-req)
(provide post-req)
(provide delete-req)

(define (get-req url)
   (handle-response (get url)))

(define (post-req url body)
  (handle-response
    (post url #:json body)))

(define (delete-req url)
  (handle-response (delete url)))

(define (handle-response resp)
  (hasheq 'status-code (response-status-code resp) 
          'body (response-json resp)))
