;;****************
;;* DEFFUNCTIONS *
;;****************

(defglobal ?*logging* = 1)

(deffunction logmsg (?msg $?args)
	(if (= ?*logging* 1) 
		then
		(printout t ?msg ?args crlf)))
		
		

(deffunction symbolToString (?symb)
	(implode$ (create$ ?symb))
)

(deffunction ask-question (?question)
	(printout t ?question)
	(readline))

(deffunction ask-multiple-choice-question (?question $?allowed-values)
   (bind ?answer (ask-question ?question))
   (logmsg "Given answer is: " ?answer " Allowed values are: " ?allowed-values)
   (while (not (member ?answer ?allowed-values)) do
      (bind ?answer (ask-question ?question))
      (logmsg "Bad answer: " ?answer  " Allowed values are: " ?allowed-values)
	  )
   ?answer)
 
(deffunction ask-open-question (?question)
	(bind ?answer (ask-question ?question))
	(while (not (lexemep ?answer)) do
		(bind ?answer (ask-question ?question)))
	?answer)



;;**********************
;;  DEFTEMPLATE
;;**********************



(deftemplate status
    (multislot found-instances)
    (slot searched-name)
    (slot searched-type)
    (slot searched-playedBy)
    (slot searching-state)
    (slot end-get-all-instances)
) 


;;**********************
;;  DEFRULES 
;;**********************


(defrule begin-init (declare (salience 150))
	=>
	(assert (status)))



(defrule getAllInstances (declare (salience 100))
	?current <- (status (found-instances $?x)(end-get-all-instances nil))
	?instance <- (object (is-a Instrument))
	(test (not (member ?instance (create$ $?x))))
	(not (end-get-all-instances))
	=>
	(modify ?current (found-instances ?instance $?x)))


(defrule end-init (declare (salience 50))
  ?status <- (status (end-get-all-instances nil))
	=>
  (modify ?status (end-get-all-instances FALSE) (searching-state insearch)))



(defrule specify-name (declare (salience 10))
	?status <- (status (searching-state insearch) (searched-name nil))
	=>
	(bind ?search (ask-open-question "Specify instrument name: "))
	(modify ?status (searched-name ?search)))


(defrule search-name (declare (salience 10))
	?status <- (status (searched-name ?search&~nil)(found-instances $?allfound))
	?found <- (object (is-a Instrument) (name_ ?fname&~?search))
  (test (neq "" ?search))
	=>
;  (printout t "Removing: " ?fname crlf)
	(bind ?memberposition (member ?found (create$ $?allfound)))
	(if ?memberposition
		then
		(modify ?status (found-instances (delete$ (create$ $?allfound) ?memberposition ?memberposition)))))


(defrule specify-type (declare (salience 13))
	?status <- (status (searching-state insearch) (searched-type nil))
	=>
	(bind ?search (ask-multiple-choice-question "Specify a type (jazz/classical/rock): " "jazz" "classical" "rock"))
	(modify ?status (searched-type ?search)))
	
(defrule search-type (declare (salience 13))
	?status <- (status (searched-type ?search&~nill) (found-instances $?allfound))
	?found <- (object (is-a Instrument) (type ?fName&~?search))
	=>
	(bind ?memberposition (member ?found (create$ $?allfound)))
	(if ?memberposition
		then
		(modify ?status (found-instances (delete$ (create$ $?allfound) ?memberposition ?memberposition)))))



(defrule specify-playedBy (declare (salience 9))
  ?status <- (status (searching-state insearch) (searched-playedBy nil))
  =>
  (bind ?search (ask-open-question "Spacify musicians first name: "))
  (modify ?status (searched-playedBy ?search)))


(defrule search-playedBy (declare (salience 9))
  ?status <- (status (searched-playedBy ?search&~nil) (found-instances $?allfound))
  ?foundM <- (object (is-a Instrument))
  (test (neq "" ?search))
  ;the following will not match  if there is no such musician or if the wanted instrument is not played by this musician
  (or
    (not (object (is-a Musician) (firstName ?search) ) )
    (not (object (is-a Musician) (firstName ?search) (playsInstrument $? ?instancename $?)))) 
  =>
  (bind ?memberposition (member ?foundM (create$ $?allfound)))
  (if ?memberposition
    then
    (modify ?status (found-instances (delete$ (create$ $?allfound) ?memberposition ?memberposition)))))



;15 because this rule should interrupt the search
(defrule end-search-fail (declare (salience 15))
  ?state <- (status (searching-state insearch) (found-instances))
  =>
  (modify ?state (searching-state endsearch))
  (printout t "No match found!" crlf))


;8 because this rule shaould be fired after every search. it's salisnce is less than all search-* rules
(defrule end-search-one (declare (salience 8))
 ?state <- (status (searching-state insearch) (found-instances ?x))
 =>
 (modify ?state (searching-state endsearch))
 (printout t "Only one match found!"  crlf)
 (send (instance-name ?x) print)
)

 
;5 because this rule should be fired after the search
(defrule end-search-found (declare (salience 5))
  ?state <- (status (searching-state insearch) (found-instances $?x))
  =>
  (modify ?state (searching-state endsearch))
  (printout t "Found result:" crlf)
  (bind ?allfound $?x)
  (while (> (length$ ?allfound) 0)
    do
    (send (instance-name (nth$ 1 ?allfound)) print)
    (bind ?allfound (rest$ ?allfound))))
