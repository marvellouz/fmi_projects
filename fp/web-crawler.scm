#lang racket
(require net/url net/uri-codec)

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

(define (validate start-url depth save-location)
  (if (or (null? start-url) (null? depth) (null? save-location)) (list #f "Моля попълнете всички полета")
      (if (directory-exists? (string->path save-location))(list #t)
          (list #f "Невалиден път"))))

(define (error e)
  )

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
  (map (lambda (str) (bytes->string/utf-8 str)) (map helper res))
  )

;list of all srcs
(define (find-all-src current-url)
  (define rx (regexp "src=\"([^>\"]+)\""))
  (define res (regexp-match* rx (get-html current-url)))
  (define (helper str) (regexp-replace rx str "\\1"))
  (map (lambda (str) (bytes->string/utf-8 str)) (map helper res))
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

;save-location must include the dile name. For example "D:\\FMI\\fmi_projects\\fp\\picture.jpg"
(define (save! current-url save-location)
  (define in (get-html current-url))
  (define out (open-output-file (string->path save-location)))
  (read-and-write in out)
  (close-output-port out))

;=========================================================================================

(define (crawl current-url depth save-location)
  (let (resources (normalize-resources (find-all-resources current-url)))
    (begin
      (save-html! current-url save-location file-name)
      (save-resources! resources))))
  
(define (calculate-local-location res save-location) 
  
  )
  
(define (save-resources! resources save-location)
  (let (res (car resources)))
  (begin
    (save! res (calculate-local-location res save-location))
    (save-resources! (cdr resources) save-location))
  )

(define (main start-url depth save-location)
  (let (valid (validate start-url depth save-location file-name)))
  (if (car valid)
      (crawl start-url depth save-location)
      (error (cdr valid))))