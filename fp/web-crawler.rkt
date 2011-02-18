#lang racket
(require net/url net/uri-codec)
(require racket/set)
(require "page.scm")
(require file/md5)

(define visited-hrefs (set))

; Simple web scraper
;(define (let-me-google-that-for-you str)
;  (let* ([g "http://www.google.com/search?q="]
;         [u (string-append g (uri-encode str))]
;         [rx #rx"(?<=<h3 class=\"r\">).*?(?=</h3>)"])
;    (regexp-match* rx (get-pure-port (string->url u)))))



;(define (valid-url? url)
;  (with-handlers ([exn:fail? (lambda (v) #f)])
;    (get-pure-port (string->url url))
;  ))



;(define (error e))

(define (base-url u)
  ;"http://someurl.com/images/foo/bar..." -> http://someurl.com/
  (url->string (make-url (url-scheme u) #f (url-host u) #f #f '() '() #f))
  )

;(url->string (combine-url/relative (string->url "http://asd.ds/x/y/z") "../a/b/c"))
;"http://asd.ds/x/a/b/c"
(define (normalize-resources current-url resource)
  (combine-url/relative current-url resource))

;list of all hrefs
(define (find-all-hrefs current-url)
  (define rx (regexp "href=\"([^>\"]*)\""))
  (define res (regexp-match* rx (get-html current-url)))
  (define (helper str) (regexp-replace rx str "\\1"))
  (map url->string (map (lambda (x) (normalize-resources (string->url current-url) x)) (map (lambda (str) (bytes->string/utf-8 str)) (map helper res))))
  )

;list of all srcs
(define (find-all-src current-url)
  (define rx (regexp "src=\"([^>\"]+)\""))
  (define res (regexp-match* rx (get-html current-url)))
  (define (helper str) (regexp-replace rx str "\\1"))
  (map url->string (map (lambda (x) (normalize-resources (string->url current-url) x)) (map (lambda (str) (bytes->string/utf-8 str)) (map helper res))))
  )

;========================================================================================

(define (get-html u)
  (get-pure-port (string->url u)))

(define (read-and-write in out)
  (let ((res (read-bytes 512 in)))
    (if (not (eof-object? res))
        (begin
          (write-bytes res out)
          (read-and-write in out))
        out)))

;save-location "D:\\FMI\\fmi_projects\\fp\\"
;to add "http://a.b/c.jpg" -> "D:\\FMI\\fmi_projects\\fp\\src\\53413520368201237500034"
;dos save-location exist?
(define (save! current-url save-location save-sublocation)
  (define in (get-html current-url))
  (define out (open-output-file (string->path (calculate-local-location current-url save-location save-sublocation))))
  (read-and-write in out)
  (close-output-port out))

;=========================================================================================

(define (crawl start-url depth save-location)
  (if (= 0 depth) #f
      (let (
            (hrefs (find-all-hrefs start-url))
            (src (find-all-src start-url))
            )
        (begin
          (save! start-url save-location "")
          (save-resources! hrefs save-location "hrefs\\")
          (save-resources! src save-location "src\\")
          (set! visited-hrefs(set-add visited-hrefs start-url))
          (for-each (lambda (x) (crawl-all x (- depth 1) save-location))
                    hrefs)
          ;(crawl-all (car hrefs) (-depth 1) save-location)
          ))))

(define (crawl-all current-url depth save-location)
  (if (= 0 depth) #f
      (let (
            (hrefs (find-all-hrefs current-url))
            (src (find-all-src current-url))
            )
        (if (not (set-member? visited-hrefs current-url))
            (begin
              (save! current-url save-location "hrefs\\")
              (save-resources! hrefs save-location "hrefs\\")
              (save-resources! src save-location "src\\")
              (set! visited-hrefs(set-add visited-hrefs current-url))
              (for-each (lambda (x) (crawl-all x (- depth 1) save-location))
                        (find-all-hrefs current-url))
              )
            
            (for-each (lambda (x) (crawl-all x (- depth 1) save-location))
                      ;всички hrefs без първия
                      (cdr (find-all-hrefs current-url)))
            )
        )
      )
  )

(define (calculate-local-location res save-location save-sublocation) 
  (string-append save-location save-sublocation (bytes->string/utf-8 (md5 res))))

(define (save-resources! resources save-location save-sublocation)
  (let ((res (car resources)))
    (begin
      (save! res (calculate-local-location res save-location save-sublocation)save-sublocation)
      (save-resources! (cdr resources) save-location))))

(define (validate start-url depth save-location)
  (if (or (null? start-url) (null? depth) (null? save-location)) (list #f "Моля попълнете всички полета")
      (if (directory-exists? (string->path save-location))(list #t)
          (list #f "Невалиден път"))))

(define (main start-url depth save-location)
  (let ((valid (validate start-url depth save-location)))
  (if (car valid)
      (crawl start-url depth save-location)
      (error (cdr valid)))))