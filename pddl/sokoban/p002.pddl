(define (problem sokoban-multi-box)
  (:domain sokoban)
  (:objects
    p1 - player
    b1 b2 - box
    c1 c2 c3 c4 c5 c6 c7 c8 c9 - position
  )

  (:init
    (at p1 c1)      ; Le joueur commence en c1
    (box-at b1 c3)  ; Boîte 1 commence en c3
    (box-at b2 c5)  ; Boîte 2 commence en c5
    (goal c7)       ; Objectif pour b1
    (goal c9)       ; Objectif pour b2

    ;; Définition des adjacences bidirectionnelles
    (adjacent c1 c2) (adjacent c2 c1)
    (adjacent c2 c3) (adjacent c3 c2)
    (adjacent c3 c4) (adjacent c4 c3)
    (adjacent c4 c5) (adjacent c5 c4)
    (adjacent c5 c6) (adjacent c6 c5)
    (adjacent c6 c7) (adjacent c7 c6)
    (adjacent c7 c8) (adjacent c8 c7)
    (adjacent c8 c9) (adjacent c9 c8)

    ;; Ajout de cases `clear` pour garantir que le chemin est possible
    (clear c2) (clear c4) (clear c6) (clear c7) (clear c8) (clear c9)
    (clear c1)  ; Permettre au joueur de se déplacer au début
  )

  (:goal
    (and (box-at b1 c7) (box-at b2 c9))
  )
)
