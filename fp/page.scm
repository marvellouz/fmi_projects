#lang racket

(provide make-page)
(provide link)
(provide hrefs)
(provide src)
(provide parent)

(define (link page)
  (car page))

(define (hrefs page)
  (cadr page))

(define (src page)
  (caddr page))

(define (parent page)
  (cadddr page))

(define (make-page link hrefs src parent)
  (list link hrefs src parent))