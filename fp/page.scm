#lang racket

(provide make-page)
(provide url)
(provide hrefs)
(provide src)
(provide parent)

(define (url page)
  (car page))

(define (hrefs page)
  (cadr page))

(define (src page)
  (caddr page))

(define (parent page)
  (cadddr page))

(define (make-page url hrefs src parent)
  (list url hrefs src parent))