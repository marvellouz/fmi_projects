#lang racket
(require net/url net/uri-codec)
(require racket/set)
(require "page.rkt")

(define visited-hrefs (set))

(define (base-url u)
  (url->string (make-url (url-scheme u) #f (url-host u) #f #f '() '() #f))
  )

(define (normalize-resources url resource)
  (combine-url/relative url resource))

  (define (find-all-in-url url rx)
    (define res (regexp-match* rx (get-html url)))
    (define (helper str) (regexp-replace rx str "\\1"))
    (map url->string (map (lambda (x) (normalize-resources (string->url url) x))
                          (map (lambda (str) (bytes->string/utf-8 str))
                               (map helper res))))
    )

;list of all hrefs
(define (find-all-hrefs url)
  (find-all-in-url url (regexp "href=\"([^>\"]*)\"")))

;list of all srcs
(define (find-all-src url)
  (find-all-in-url (regexp "src=\"([^>\"]+)\"")))

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

;dir "D:\\FMI\\fmi_projects\\fp\\"
;to add "http://a.b/c.jpg" -> "D:\\FMI\\fmi_projects\\fp\\src\\5334141"
(define (save! url dir subdir)
  (define in (get-html url))
  (define out (open-output-file (string->path
                                    (calculate-local-location url dir subdir))))
  (read-and-write in out)
  (close-output-port out))

;=========================================================================================

(define (crawl start-url depth save-location)
  (if (= 0 depth) #f
    (let* (
          (hrefs (find-all-hrefs start-url))
          (src (find-all-src start-url))
          (start-page (make-page start-url hrefs src null))
          )
      (begin
        (save! start-url (build-path save-location))
        (save-resources! hrefs (build-path save-location "hrefs"))
        (save-resources! src (build-path save-location "src")
                         (set! visited-hrefs (set-add visited-hrefs start-url))
                         (for-each (lambda (x) 
                                     (crawl-all (- depth 1) save-location
                                                (make-page x (find-all-hrefs x) (find-all-src x) start-page)
                                                ))
                                   hrefs)
                         )
        )
      )
    )
  )

(define (crawl-all depth save-location current-page)
  (if (= 0 depth) #f
    (let (
          (page-hrefs (page-hrefs current-page))
          (page-src (page-src current-page))
          (current-url (link current-page))
          (parent-page (parent current-page))
          )
      ;ако страницата не е посетена вече, ще се изпълни втората част на and.
      ;Иначе ще върне #f и няма да продължи с изпълнението на втората част.
      (and 
        ((not (set-member? visited-hrefs current-url)))
        (begin
          (save! current-url (build-path save-location "hrefs"))
          (save-resources! hrefs (build-path save-location "hrefs"))
          (save-resources! src (build-path save-location "src"))
          (set! visited-hrefs (set-add visited-hrefs current-url))
          (for-each (lambda (x) (crawl-all (- depth 1) save-location)
                      (make-page x (find-all-hrefs x)
                                 (find-all-src x)
                                 current-page))
                    hrefs))))))

(define (calculate-local-location res dir) 
  (build-path dir (bytes->string/utf-8 (md5 res))))

(define (save-resources! resources save-location save-sublocation)
  (let (res (car resources)))
  (begin
    (save! res (calculate-local-location res save-location))
    (save-resources! (cdr resources) save-location)))

(define (validate start-url depth save-location)
  (if (or (null? start-url) (null? depth) (null? save-location)) (cons #f "Моля попълнете всички полета")
    (if (directory-exists? (string->path save-location))
      (cons #t)
      (cons #f "Невалиден път"))))

(define (main start-url depth save-location)
  (let (valid (validate start-url depth save-location file-name)))
  (if (car valid)
      (crawl start-url depth save-location)
      (error (cdr valid))))

(main "http://google.com/" "/tmp/foo/")
