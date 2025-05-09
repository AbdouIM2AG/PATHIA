(define (domain sokoban)
  (:requirements :strips :typing)
  (:types position box player)

  (:predicates 
    (at ?p - player ?x - position)  ; Le joueur est en ?x
    (box-at ?b - box ?x - position) ; Une boîte est en ?x
    (goal ?x - position)            ; Objectif en ?x
    (clear ?x - position)           ; La position ?x est libre
    (adjacent ?x1 ?x2 - position)   ; Adjacence entre ?x1 et ?x2
  )

  ;; Déplacement du joueur vers une case libre adjacente
  (:action move
    :parameters (?p - player ?x1 ?x2 - position)
    :precondition (and 
      (at ?p ?x1) 
      (clear ?x2) 
      (adjacent ?x1 ?x2)
    )
    :effect (and 
      (not (at ?p ?x1))
      (at ?p ?x2)
      (clear ?x1)
    )
  )

  ;; Pousser une boîte vers une case libre
  (:action push
    :parameters (?p - player ?b - box ?x1 ?x2 ?x3 - position)
    :precondition (and 
      (at ?p ?x1) 
      (box-at ?b ?x2)
      (adjacent ?x1 ?x2)
      (adjacent ?x2 ?x3)
      (clear ?x3)
    )
    :effect (and 
      (not (at ?p ?x1))
      (at ?p ?x2)
      (not (box-at ?b ?x2))
      (box-at ?b ?x3)
      (clear ?x1)  ; L’ancienne position du joueur devient libre
      (not (clear ?x3))  ; La boîte occupe maintenant ?x3
    )
  )
)
