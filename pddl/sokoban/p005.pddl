(define (problem sokoban-solved)
  (:domain sokoban)
  (:objects p1 - player b1 - box c1 c2 - position)
  (:init (at p1 c1) (box-at b1 c2) (goal c2) (adjacent c1 c2) (clear c1))
  (:goal (box-at b1 c2))
)
