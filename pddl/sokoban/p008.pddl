(define (problem sokoban-long-start)
  (:domain sokoban)
  (:objects
    p1 - player
    b1 - box
    c1 c2 c3 c4 c5 c6 c7 c8 c9 - position
  )

  (:init
    (at p1 c1)
    (box-at b1 c7)
    (goal c9)
    (adjacent c1 c2) (adjacent c2 c1)
    (adjacent c2 c3) (adjacent c3 c2)
    (adjacent c3 c4) (adjacent c4 c3)
    (adjacent c4 c5) (adjacent c5 c4)
    (adjacent c5 c6) (adjacent c6 c5)
    (adjacent c6 c7) (adjacent c7 c6)
    (adjacent c7 c8) (adjacent c8 c7)
    (adjacent c8 c9) (adjacent c9 c8)
    (clear c2) (clear c3) (clear c4) (clear c5) (clear c6) (clear c8) (clear c9)
  )

  (:goal
    (box-at b1 c9)
  )
)
