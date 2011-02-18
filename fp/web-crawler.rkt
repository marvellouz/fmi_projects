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
  (define output-file (string->path (calculate-local-location current-url save-location save-sublocation)))
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
          (save! start-url save-location null)
          (and (not (null? hrefs))
               (save-resources! hrefs save-location "hrefs\\"))
          (and (not(null? src))
               (save-resources! src save-location "src\\"))
          (set! visited-hrefs(set-add visited-hrefs start-url))
          (for-each (lambda (x) (crawl-all (- depth 1) save-location (make-page x (find-all-hrefs x) (find-all-src x) start-page)))
                    hrefs)
          ;(crawl-all (car hrefs) (-depth 1) save-location)
          ))))

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
           (save! current-url save-location "hrefs\\")
           (save-resources! hrefs save-location "hrefs\\")
           (save-resources! src save-location "src\\")
           (set! visited-hrefs(set-add visited-hrefs current-url))
           (for-each (lambda (x) (crawl-all (- depth 1) save-location)(make-page x (find-all-hrefs x) (find-all-src x) current-page))
                     hrefs))))))


(define (calculate-local-location res save-location save-sublocation)
  (let ([file-location (if ( equal? (url-host (string->url res))
                                    (string-append 
                                     (url-host (string->url res))
                                     (string-join (map (lambda(x) (path/param-path x)) (url-path (string->url res))) "/"))
                            )
                             (build-path
                                     (url-host (string->url res)) "index.html")
                            (build-path 
                                     (url-host (string->url res))
                                     (string-join (map (lambda(x) (path/param-path x)) (url-path (string->url res))) "/")))]
       )
    (if (not(null? save-sublocation))
        (begin
          (display (string-append save-location "\n"))
        (path->string (build-path save-location save-sublocation 
                                  file-location))
        )
        (path->string(build-path save-location 
                                 file-location)))))

(define (save-resources! resources save-location save-sublocation)
  (let ((res (car resources)))
    (begin
      (save! res save-location save-sublocation)
      (save-resources! (cdr resources) save-location save-sublocation))))

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