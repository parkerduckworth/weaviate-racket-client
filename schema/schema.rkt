#lang racket/base

(require json)
(require net/http-easy)
(require "../client/client.rkt")
(require "../http/http.rkt")

(provide (struct-out schema))
(provide (struct-out class))
(provide get-schema)
(provide get-class)

;; TODO: support entire class object
(struct class [name properties] #:transparent)

(struct schema [classes] #:transparent)

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
  (define classes (hash-ref resp 'classes))
  (schema (parse-classes classes)))

(define (get-class client name)
  (define resp (get-req (class-url client name)))
  (parse-class resp))

(define (parse-classes classes)
  (map parse-class classes))

(define (parse-class cls)
  (class 
    (hash-ref cls 'class)
    (hash-ref cls 'properties)))
