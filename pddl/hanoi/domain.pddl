(define (domain hanoi-ff)
  (:requirements :strips :typing :negative-preconditions)
  (:types disk peg - object)
  (:predicates
    (on ?d - disk ?s - object)      ; Un disque peut être posé sur un peg ou sur un autre disque.
    (clear ?x - object)             ; L'objet (peg ou disk) ?x n'a rien posé dessus.
    (smaller ?d1 - disk ?d2 - disk)   ; ?d1 est strictement plus petit que ?d2.
  )

  ;; Action permettant de déplacer un disque vers un peg (la base) s'il est dégagé.
  (:action move-to-peg
    :parameters (?d - disk ?from - object ?p - peg)
    :precondition (and (on ?d ?from) (clear ?d) (clear ?p))
    :effect (and (not (on ?d ?from))
                 (on ?d ?p)
                 (clear ?from)
                 (not (clear ?p)))
  )

  ;; Action permettant de déplacer un disque vers un autre disque (pour empiler)
  (:action move-to-disk
    :parameters (?d - disk ?from - object ?d2 - disk)
    :precondition (and (on ?d ?from) (clear ?d) (clear ?d2) (smaller ?d ?d2))
    :effect (and (not (on ?d ?from))
                 (on ?d ?d2)
                 (clear ?from)
                 (not (clear ?d2)))
  )
)
