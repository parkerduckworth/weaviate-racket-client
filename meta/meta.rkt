#lang racket/base

(require json)
(require "../client/client.rkt")
(require "../http/http.rkt")

(provide get-meta)

(define (url client)
  (string-append 
    (weaviate-client-hostname client) 
    "/v1/meta"))

(define (get-meta client)
  (define resp (get-req (url client)))
  resp)
