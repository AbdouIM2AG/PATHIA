(define (problem sokoban-multi-box-3)
  (:domain sokoban)
  (:objects
    p1 - player
    b1 b2 b3 - box
    c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 - position
  )

  (:init
    (at p1 c1)
    (box-at b1 c3)
    (box-at b2 c6)
    (box-at b3 c9)
    (goal c10)
    (goal c11)
    (goal c12)
    ;; Adjacences
    (adjacent c1 c2) (adjacent c2 c1)
    (adjacent c2 c3) (adjacent c3 c2)
    (adjacent c3 c4) (adjacent c4 c3)
    (adjacent c4 c5) (adjacent c5 c4)
    (adjacent c5 c6) (adjacent c6 c5)
    (adjacent c6 c7) (adjacent c7 c6)
    (adjacent c7 c8) (adjacent c8 c7)
    (adjacent c8 c9) (adjacent c9 c8)
    (adjacent c9 c10) (adjacent c10 c9)
    (adjacent c10 c11) (adjacent c11 c10)
    (adjacent c11 c12) (adjacent c12 c11)
    ;; Cases libres
    (clear c2) (clear c4) (clear c5) (clear c7) (clear c8) (clear c10) (clear c11) (clear c12)
  )

  (:goal
    (and (box-at b1 c10) (box-at b2 c11) (box-at b3 c12))
  )
)
