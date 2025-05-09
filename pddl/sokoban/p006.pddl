(define (problem sokoban-solved)
  (:domain sokoban)
  (:objects
    p1 - player
    b1 b2 - box
    c1 c2 c3 c4 - position
  )

  (:init
    (at p1 c1)
    (box-at b1 c2)
    (box-at b2 c3)
    (goal c2)
    (goal c3)
    (adjacent c1 c2) (adjacent c2 c1)
    (adjacent c2 c3) (adjacent c3 c2)
    (clear c1) (clear c4)
  )

  (:goal
    (and (box-at b1 c2) (box-at b2 c3))
  )
)
