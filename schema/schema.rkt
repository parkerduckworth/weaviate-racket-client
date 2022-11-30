#lang racket/base

(require json)
(require net/http-easy)
(require "../client/client.rkt")
(require "../http/http.rkt")

(provide get-schema)
(provide get-class)
(provide create-class)
(provide update-class)
(provide delete-class)

(define (schema-url client)
  (string-append 
    (weaviate-client-hostname client) 
     "/v1/schema"))

(define (class-url client name)
  (string-append
    (weaviate-client-hostname client)
    "/v1/schema/"
    name))

(define (get-schema client)
  (define resp (get-req (schema-url client)))
  resp)

(define (get-class client name)
  (define resp (get-req (class-url client name)))
  resp)

(define (create-class client cls)
  (define body cls)
  (define resp (post-req (schema-url client) body))
  resp)

(define (update-class client cls)
  (define body cls)
  (define name (hash-ref cls 'class))
  (define url (class-url client name))
  (define resp (put-req url body))
  resp)

(define (delete-class client name)
  (define resp (delete-req (class-url client name)))
  resp)
