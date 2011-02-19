#lang racket

(provide make-page)
(provide page-url)
(provide page-hrefs)
(provide page-src)
(provide page-parent)

(define (page-url page)
  (car page))

(define (page-hrefs page)
  (cadr page))

(define (page-src page)
  (caddr page))

(define (page-parent page)
  (cadddr page))

(define (make-page url hrefs src parent)
  (list url hrefs src parent))
