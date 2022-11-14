#lang racket/base

(require json)
(require "../client/client.rkt")
(require "../http/http.rkt")

(provide (struct-out meta))
(provide get-meta)

(struct meta [hostname modules version] #:transparent)

(define (url client)
  (string-append 
    (weaviate-client-hostname client) 
    "/v1/meta"))

(define (get-meta client)
  (define resp (get-req (url client)))
  (meta
   (hash-ref resp 'hostname)
   (hash-ref resp 'modules)
   (hash-ref resp 'version)))
