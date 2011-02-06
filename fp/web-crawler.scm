#lang racket
(require net/url net/uri-codec)

; Simple web scraper
;(define (let-me-google-that-for-you str)
;  (let* ([g "http://www.google.com/search?q="]
;         [u (string-append g (uri-encode str))]
;         [rx #rx"(?<=<h3 class=\"r\">).*?(?=</h3>)"])
;    (regexp-match* rx (get-pure-port (string->url u)))))


(define (main start-url depth save-location)
  (let (valid (validate start-url depth save-location)))
  (if (car valid)
      (crawl start-url depth save-location)
      (error (cdr valid))))


(define (validate start-url depth save-location))

(define (error e))


(define (base-url u)
  ;"http://someurl.com/images/foo/bar..." -> http://someurl.com/
  (url->string (make-url (url-scheme u) #f (url-host u) #f #f '() '() #f))
  )

;(define (parent-url url)
  ;"http://1/2/3" -> "http://1/2"
;  )

;(define (normalize-parents location)

;(define (absolute-url current-url location)
  ;"/images/...." -> base-url + "images/..."
  ;"../../neshtosi/" -> normalize-parents "../../neshtosi/"
  ;....
  ;??????
;  )

;(url->string (combine-url/relative (string->url "http://asd.ds/x/y/z") "../a/b/c"))
;"http://asd.ds/x/a/b/c"
(define (normalize-resources current-url resource)
  (combine-url/relative current-url resource))

(define (find-all-resources current-url)
  
  )

(define (save-html! current-url save-location))

(define (crawl current-url depth save-location)
  (let (resources (normalize-resources (find-all-resources current-url)))
    (begin
      (save-html! current-url save-location)
    (save-resources! resources)
  )))
  
(define (calculate-local-location res save-location) 
  
  )

(define (save! url location))
  
(define (save-resources! resources save-location)
  (let (res (car resources)))
  (begin
    (save! res (calculate-local-location res save-location))
    (save-resources! (cdr resources) save-location))
  )