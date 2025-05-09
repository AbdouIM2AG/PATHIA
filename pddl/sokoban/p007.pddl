(define (problem sokoban-two-players)
  (:domain sokoban)
  (:objects
    p1 p2 - player
    b1 - box
    c1 c2 c3 c4 c5 - position
  )

  (:init
    (at p1 c1)
    (at p2 c2)
    (box-at b1 c3)
    (goal c5)
    (adjacent c1 c2) (adjacent c2 c1)
    (adjacent c2 c3) (adjacent c3 c2)
    (adjacent c3 c4) (adjacent c4 c3)
    (adjacent c4 c5) (adjacent c5 c4)
    (clear c1) (clear c4) (clear c5)
  )

  (:goal
    (box-at b1 c5)
  )
)
