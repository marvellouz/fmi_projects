#lang racket
(require net/url net/uri-codec)
(require racket/set)
(require "page.rkt")
(require file/md5)
(require unstable/path)

(define visited-hrefs (set))
(define (visited! url)
     (set! visited-hrefs (set-add visited-hrefs url))
  )
(define (visited? url)
  (set-member? visited-hrefs url)
  )

(define (base-url u)
  (url->string (make-url (url-scheme u) #f (url-host u) #f #f '() '() #f))
  )

(define (normalize-resources current-url resource)
  (string->url (regexp-replace "#.*"
                               (url->string (combine-url/relative current-url resource))
                               "" )))

(define (find-all-in-url url rx)
  (define res (regexp-match* rx (get-html url)))
  (define (helper str) (regexp-replace rx str "\\1"))
  (map url->string
       (map (lambda (x) (normalize-resources (string->url url) x))
            (map (lambda (str) (bytes->string/utf-8 str)) (map helper res)))))

;list of all hrefs
(define (find-all-hrefs url)
  (find-all-in-url url (regexp "href=\"([^>\"]*)\"")))

;list of all srcs
(define (find-all-src url)
  (find-all-in-url url (regexp "src=\"([^>\"]+)\"")))

;========================================================================================

(define (get-html u)
  (begin
    (get-pure-port (string->url u))))

(define (read-and-write in out)
  (let ((res (read-bytes 512 in)))
    (if (not (eof-object? res))
        (begin
          (write-bytes res out)
          (read-and-write in out))
        out)))

(define (save! current-url save-location)
  (define in (get-html current-url))
  (define output-file (calculate-local-location current-url save-location))
  (and (not (directory-exists? (directory-part output-file)))
       (make-directory* (directory-part output-file)))
  (define out (open-output-file output-file))
  (read-and-write in out)
  (close-output-port out))

;=========================================================================================

(define (crawl-all depth save-location current-page)
  (if (= 0 depth) #f
      (let (
            (hrefs (page-hrefs current-page))
            (src (page-src current-page))
            (current-url (page-url current-page))
            (parent-page (page-parent current-page))
            )
        ;ако страницата не е посетена вече, ще се изпълни втората част на and.
        ;Иначе ще върне #f и няма да продължи с изпълнението на втората част.
        (and 
         (not (set-member? visited-hrefs current-url))
         (begin
           (save! current-url save-location)
           (save-resources! hrefs save-location)
           (save-resources! src save-location)

           (set! visited-hrefs(set-add visited-hrefs current-url))
           (display (set-count visited-hrefs))
           (for-each (lambda (x)
                       (crawl-all
                         (- depth 1)
                         save-location)
                       (make-page x 
                                  (find-all-hrefs x)
                                  (find-all-src x)
                                  current-page))
                     hrefs))))))

(define (url-path-from-url url)
  (string-join (map (lambda(x) (path/param-path x))
                    (url-path (string->url url)))
               "\\"))

(define (path-from-url url)
  (if(equal? "" (url-path-from-url url))
     (build-path (url-host (string->url url)))
     (build-path (url-host (string->url url)) (url-path-from-url url))))


(define (calculate-local-location res save-location)
  (let ([file-location (if (equal? (url-host (string->url res)) (path->string (path-from-url res)))
                           (build-path
                            (url-host (string->url res)) "index.html")
                           (path-from-url res))])
      (build-path save-location file-location)))

(define (save-resources! resources save-location )
  (if (null? resources) #f
      (let ((res (car resources)))
        (begin
          (and (not (visited? res))
               (begin
                 (save! res save-location)
                 (visited! save-location))
          (save-resources! (cdr resources) save-location ))))))

(define (validate depth start-url save-location)
  (if (or (null? start-url) (null? depth) (null? save-location)) (cons #f "Моля попълнете всички полета")
      (if (directory-exists? (string->path save-location)) (cons #t "")
          (cons #f "Невалиден път"))))

(define (main depth start-url save-location)
  (let ((valid (validate depth start-url save-location)))
    (and
     (car valid)
     (crawl-all depth save-location
                (make-page  start-url
                            (find-all-hrefs start-url)
                            (find-all-src start-url)
                            null))
     )))

(main 3 "http://google.com/" "/tmp/foo/")
