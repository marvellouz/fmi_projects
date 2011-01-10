;----------------------------------------------
;
; Автор: Валентина Динкова
; Ф.н.: 71112
;

(define (process! T)
  (define (last x)
    (if (null? (cdr x)) x
        (last (cdr x))))
  
  (define (append! x y)
    (begin (set-cdr! (last x) y)
           x))
  
  (define (sum l)
    (if (null? l) 0
        (+ (car l)(sum (cdr l)))))

  (define (sumlists l1 l2)
    (cond ((null? l1) l2)
          ((null? l2) l1)
          (else (append (list (+ (car l1) (car l2))) (sumlists (cdr l1) (cdr l2))))) )
  
  (define (sumcols T)
    (if (null? (cdr T)) (car T)
        (sumlists(sumlists (car T) (cadr T)) (sumcols (cddr T)) )))
  
  (define (process-rows! T)
    (cond ((null? T) T)
          (else (append! (car T) (list(sum (car T)))) (process-rows! (cdr T)))))
  
  (define (process-cols! T)
    (cond ((null? T) T)
          (else (append! T (list(sumcols T))))))
  (if (or (null? T) (null? (car T)) ) T
      (begin 
        (process-rows! T)
        (process-cols! T))))

