#lang racket/base

(require rackunit)
(require racket/pretty)
(require "helper.rkt")
(require "../client/client.rkt")
(require "../schema/schema.rkt")

(module+ test
  (define client (weaviate-client "localhost:8080"))
  (define test-class "SuperClass")

  ;; create class
  (define create-class-resp (create-class
    client
    (hasheq 
      'class test-class
      'properties `(
        ,(hasheq 'name "stringProp" 'dataType '("string"))
        ,(hasheq 'name "intProp" 'dataType '("int"))))))
  (define created (hash-ref create-class-resp 'body))
  (check-equal? (hash-ref created 'class) test-class)
  
  ;; get class
  (define get-class-resp (get-class client test-class))  
  (define fetched (hash-ref get-class-resp 'body))
  (check-equal? created fetched)

  ;; update class
  (define new-vec-idx-cfg
    (hash-set 
      (hash-ref fetched 'vectorIndexConfig) 
      'ef 
      -2))
  (define update-payload
    (hash-set fetched 'vectorIndexConfig new-vec-idx-cfg))
  (define update-class-resp (update-class client update-payload))
  (define get-updated-class-resp (get-class client test-class))  
  (define fetched-updated (hash-ref get-updated-class-resp 'body))
  (check-equal? update-payload fetched-updated)

  ;; delete class
  (define delete-class-resp (delete-class client test-class))
  (define status-code (hash-ref delete-class-resp 'status-code))
  (check-equal? status-code 200))
