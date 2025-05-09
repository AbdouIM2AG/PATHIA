;; domain.taquin-ff.pddl
(define (domain taquin-ff)
  (:requirements :strips :typing :negative-preconditions)
  (:types tile position - object)
  (:predicates
    (at     ?t - tile     ?p - position)    ; la case p contient la tuile t
    (empty  ?p - position)                  ; la case p est vide
    (adjacent ?p1 - position ?p2 - position); p1 et p2 sont voisines
  )

  ;; action de glissement : on déplace la tuile t de p1 vers p2
  (:action slide
    :parameters (?t - tile ?p1 - position ?p2 - position)
    :precondition (and (at ?t ?p1)
                       (empty ?p2)
                       (adjacent ?p1 ?p2))
    :effect     (and (not (at ?t ?p1))
                     (at     ?t ?p2)
                     (not (empty ?p2))
                     (empty  ?p1)))
)
