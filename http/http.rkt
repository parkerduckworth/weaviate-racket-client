#lang racket/base

(require net/http-easy)

(provide get-req)

(define (get-req url)
   (response-json (get url)))
