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
;;  DEFRULES 
;;**********************


(defrule begin-init (declare (salience 150))
	=>
	(assert (found-instances))
)

(defrule getAllInstances (declare (salience 100))
	?current <- (found-instances $?x)
	?instance <- (object (is-a Instrument))
	(test (not (member ?instance (create$ $?x))))
	(not (end-get-all-instances))
	=>
	(retract ?current)
	(assert (found-instances ?instance $?x))
)

(defrule end-init (declare (salience 50))
	=>
	(assert (searched-name unknown))
	(assert (searched-type unknown))
;	(assert (searched-playedBy unknown))
	(assert (searching-state insearch))
	(assert (end-get-all-instances))
)



;(defrule spacify-playedBy (declare(salience 10))
;  (searching-state insearch)
;  ?playedBy <- (searched-playedBy unknoun)
;  =>
;  (bind ?search (ask-open-question "Who plays this instrument (specify firts name)?"))
;  (retract ?playedBy)
;  (assert (searched-playedBy ?search)))
;
; (defrule search-playedBy(declare (salience 10))
;  (searched-playedBy ?search&~unknown)
;  ?allfound-fact <- (found-instances $?allfound)
;  ?found <- (object (is-a Musician) (firstName ?fname&~?search))
;  =>
;  (bind ?memberposition (member ?found (create$ $?allfound)))
;  (if ?memberposition
;    then
;   (retract ?allfound-fact)
;   (assert (found-instances (delete$ (create$ $?allfound) ?memberposition ?memberposition)))))



(defrule specify-name (declare (salience 10))
	(searching-state insearch)
  ?name-fact <- (searched-name unknown)
	=>
	(bind ?search (ask-open-question "Specify instrument name: "))
	(retract ?name-fact)
	(assert (searched-name ?search)))

	
(defrule search-name (declare (salience 10))
	(searched-name ?search&~unknown)
	?allfound-fact <- (found-instances $?allfound)
	?found <- (object (is-a Instrument) (name ?fname&~?search))
	=>
  (printout t "Removing: " ?fname crlf)
	(bind ?memberposition (member ?found (create$ $?allfound)))
	(if ?memberposition
		then
		(retract ?allfound-fact)
		(assert (found-instances (delete$ (create$ $?allfound) ?memberposition ?memberposition)))))
		

		
(defrule specify-type (declare (salience 10))
	(searching-state insearch)
	?type-fact <- (searched-type unknown)
	=>
	(bind ?search (ask-multiple-choice-question "Specify a type(jazz/classical/rock):" Male Female))
	(retract ?type-fact)
	(assert (searched-hasGender ?search)))
	
(defrule search-type (declare (salience 10))
	(searched-type ?search&~unknown)
	?allfound-fact <- (found-instances $?allfound)
	?found <- (object (is-a Instrument) (type ?fName&~?search))
	=>
	(bind ?memberposition (member ?found (create$ $?allfound)))
	(if ?memberposition
		then
		(retract ?allfound-fact)
		(assert (found-instances (delete$ (create$ $?allfound) ?memberposition ?memberposition)))))

		

;15 because this rule should interrupt the search
(defrule end-search-fail (declare (salience 15))
	?state <- (searching-state insearch)
	(found-instances)
	=>
	(retract ?state)
	(assert (searching-state endsearch))
	(printout t "No match found!" crlf)
)

;5 because this rule should be fired after the search
(defrule end-search-found (declare (salience 5))
	?state <- (searching-state insearch)
	(found-instances $?x)
	=>
	(retract ?state)
	(assert (searching-state endsearch))
	(printout t "Found result:" crlf)
	(bind ?allfound $?x)
	(while (> (length$ ?allfound) 0)
		do
		(send (instance-name (nth$ 1 ?allfound)) print)
		(bind ?allfound (rest$ ?allfound))
	)
)
