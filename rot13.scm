;; rot13, first and complicated version
(define (rot13 some-string)
  (letrec ([rot13-helper (lambda (character rest-of-string)
                           (if (null? rest-of-string) 
                               (cons (rotate character) '())
                               (cons (rotate character) (rot13-helper (car rest-of-string) (cdr rest-of-string)))))] 
           [rotate-by (lambda (character)
                        (cond 
                          [(and (char>=? character #\a) (char<? character #\n)) 13]
                          [(and (char>=? character #\A) (char<? character #\N)) 13]
                          [(and (char>=? character #\n) (char<=? character #\z)) -13]
                          [(and (char>=? character #\N) (char<=? character #\Z)) -13]
                          [else 0]))]
           [rotate (lambda (character) 
                     (integer->char (+ (char->integer character) (rotate-by character))))] 
           [string-list (string->list some-string)]) 
    (list->string (rot13-helper (car string-list) (cdr string-list)))))

;; rot13-simple, better version with map function
(define (rot13-simple some-string)
  (define (rotate-by character)
    (cond 
      [(and (char>=? character #\a) (char<? character #\n)) 13]
      [(and (char>=? character #\A) (char<? character #\N)) 13]
      [(and (char>=? character #\n) (char<=? character #\z)) -13]
      [(and (char>=? character #\N) (char<=? character #\Z)) -13]
      [else 0]))
  (define (rotate character)
    (integer->char (+ (char->integer character) (rotate-by character))))
  (list->string (map rotate (string->list some-string))))
