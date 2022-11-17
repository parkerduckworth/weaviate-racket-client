#lang racket/base

(provide (struct-out weaviate-client))

(struct weaviate-client [hostname] #:transparent)
