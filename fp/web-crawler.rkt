#lang racket
(require net/url net/uri-codec)
(require racket/set)
(require "page.scm")
(require file/md5)
(require unstable/path)

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
  (string->url (regexp-replace "#.*" (url->string (combine-url/relative current-url resource)) "" )))

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
  ;tuk pri get pure port
  (begin
    ;e tva kvo e
    (displayln u)
    (get-pure-port (string->url u))))

(define (read-and-write in out)
  (let ((res (read-bytes 512 in)))
    (if (not (eof-object? res))
        (begin
          (write-bytes res out)
          (read-and-write in out))
        out)))

(define (save! current-url save-location )
  (define in (get-html current-url))
  (define output-file (string->path (calculate-local-location current-url save-location )))
  (and (not (directory-exists? (directory-part output-file)))
       (make-directory* (directory-part output-file)))
  (define out (open-output-file output-file))
  (read-and-write in out)
  (close-output-port out))

;=========================================================================================

(define (crawl start-url depth save-location)
  (if (= 0 depth) #f
      (let (
            (hrefs (find-all-hrefs start-url))
            (src (find-all-src start-url))
            (start-page (make-page start-url hrefs src null))
            )
        (begin
          (display (length hrefs))
          (set! visited-hrefs (set-add visited-hrefs start-url))
          (save! start-url save-location)
          
          (and (not (null? hrefs))
               (save-resources! hrefs save-location))
          
          (and (not(null? src))
               (save-resources! src save-location))
          (display (length src))
          (for-each (lambda (x) (crawl-all (- depth 1) save-location (make-page x (find-all-hrefs x) (find-all-src x) start-page)))
                    hrefs)))))

(define (crawl-all depth save-location current-page)
  (if (= 0 depth) #f
      (let (
            (hrefs (hrefs current-page))
            (src (src current-page))
            (current-url (link current-page))
            (parent-page (parent current-page))
            )
        ;ако страницата не е посетена вече, ще се изпълни втората част на and.
        ;Иначе ще върне #f и няма да продължи с изпълнението на втората част.
        (and 
         (not(set-member? visited-hrefs current-url))
         (begin
           (save! current-url save-location)
           (save-resources! hrefs save-location)
           (save-resources! src save-location)
           (set! visited-hrefs(set-add visited-hrefs current-url))
           (display (set-count visited-hrefs))
           (for-each (lambda (x) (crawl-all (- depth 1) save-location)(make-page x (find-all-hrefs x) (find-all-src x) current-page))
                     hrefs))))))

(define (url-path-from-url url)
  (string-join (map (lambda(x) (path/param-path x)) (url-path (string->url url))) "\\"))

(define (path-from-url url)
  (if(equal? "" (url-path-from-url url))
     (build-path (url-host (string->url url)))
     (build-path (url-host (string->url url)) (url-path-from-url url))))


(define (calculate-local-location res save-location)
  (let ([file-location (if ( equal? (url-host (string->url res)) (path->string (path-from-url res)))
                           (build-path
                            (url-host (string->url res)) "index.html")
                           (path-from-url res))])
    (begin
      (display (string-append save-location "\n"))
      (display (string-append res "\n"))
      (path->string (build-path save-location  
                                file-location)))))

(define (save-resources! resources save-location )
  (if (null? resources) #f
      (let ((res (car resources)))
        (begin
          (and (not (set-member? visited-hrefs res))
               (begin
                 (save! res save-location)
                 (set! visited-hrefs (set-add visited-hrefs res))))
          (save-resources! (cdr resources) save-location )))))

(define (validate start-url depth save-location)
  (if (or (null? start-url) (null? depth) (null? save-location)) (list #f "Моля попълнете всички полета")
      (if (directory-exists? (string->path save-location))(list #t)
          (list #f "Невалиден път"))))

(define (main start-url depth save-location)
  (let ((valid (validate start-url depth save-location)))
    (and
     (car valid)
     (crawl start-url depth save-location)
     )))