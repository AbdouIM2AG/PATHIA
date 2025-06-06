; testIn for level 5
(define (problem Sokoban5)
  (:domain Sokoban)
  (:objects
    p2_2 p2_3 p2_4 p2_5 p2_6 p3_2 p3_4 p3_5 p3_6 p4_2 p4_3 p4_4 p4_6 p5_3 p5_4 p5_5 p5_6 p6_1 p6_3 p6_4 p7_1 p7_3 p7_4 p7_6 p7_7 p8_1 p8_6 p8_7 - place
  )
  (:init
    (boxIsAt p3_4)
    (boxIsAt p4_3)
    (boxIsAt p5_4)
    (deadlock p2_2)
    (deadlock p2_6)
    (deadlock p4_2)
    (deadlock p5_6)
    (deadlock p6_1)
    (deadlock p7_3)
    (deadlock p7_4)
    (deadlock p7_6)
    (deadlock p7_7)
    (deadlock p8_1)
    (deadlock p8_6)
    (deadlock p8_7)
    (isDown p2_2 p3_2)
    (isDown p2_4 p3_4)
    (isDown p2_5 p3_5)
    (isDown p2_6 p3_6)
    (isDown p3_2 p4_2)
    (isDown p3_4 p4_4)
    (isDown p3_6 p4_6)
    (isDown p4_3 p5_3)
    (isDown p4_4 p5_4)
    (isDown p4_6 p5_6)
    (isDown p5_3 p6_3)
    (isDown p5_4 p6_4)
    (isDown p6_1 p7_1)
    (isDown p6_3 p7_3)
    (isDown p6_4 p7_4)
    (isDown p7_1 p8_1)
    (isDown p7_6 p8_6)
    (isDown p7_7 p8_7)
    (isEmpty p2_2)
    (isEmpty p2_3)
    (isEmpty p2_4)
    (isEmpty p2_5)
    (isEmpty p2_6)
    (isEmpty p3_2)
    (isEmpty p3_5)
    (isEmpty p3_6)
    (isEmpty p4_2)
    (isEmpty p4_4)
    (isEmpty p4_6)
    (isEmpty p5_3)
    (isEmpty p5_6)
    (isEmpty p6_1)
    (isEmpty p6_3)
    (isEmpty p6_4)
    (isEmpty p7_1)
    (isEmpty p7_3)
    (isEmpty p7_4)
    (isEmpty p7_6)
    (isEmpty p7_7)
    (isEmpty p8_1)
    (isEmpty p8_6)
    (isEmpty p8_7)
    (isLeft p2_3 p2_2)
    (isLeft p2_4 p2_3)
    (isLeft p2_5 p2_4)
    (isLeft p2_6 p2_5)
    (isLeft p3_5 p3_4)
    (isLeft p3_6 p3_5)
    (isLeft p4_3 p4_2)
    (isLeft p4_4 p4_3)
    (isLeft p5_4 p5_3)
    (isLeft p5_5 p5_4)
    (isLeft p5_6 p5_5)
    (isLeft p6_4 p6_3)
    (isLeft p7_4 p7_3)
    (isLeft p7_7 p7_6)
    (isLeft p8_7 p8_6)
    (isRight p2_2 p2_3)
    (isRight p2_3 p2_4)
    (isRight p2_4 p2_5)
    (isRight p2_5 p2_6)
    (isRight p3_4 p3_5)
    (isRight p3_5 p3_6)
    (isRight p4_2 p4_3)
    (isRight p4_3 p4_4)
    (isRight p5_3 p5_4)
    (isRight p5_4 p5_5)
    (isRight p5_5 p5_6)
    (isRight p6_3 p6_4)
    (isRight p7_3 p7_4)
    (isRight p7_6 p7_7)
    (isRight p8_6 p8_7)
    (isUp p3_2 p2_2)
    (isUp p3_4 p2_4)
    (isUp p3_5 p2_5)
    (isUp p3_6 p2_6)
    (isUp p4_2 p3_2)
    (isUp p4_4 p3_4)
    (isUp p4_6 p3_6)
    (isUp p5_3 p4_3)
    (isUp p5_4 p4_4)
    (isUp p5_6 p4_6)
    (isUp p6_3 p5_3)
    (isUp p6_4 p5_4)
    (isUp p7_1 p6_1)
    (isUp p7_3 p6_3)
    (isUp p7_4 p6_4)
    (isUp p8_1 p7_1)
    (isUp p8_6 p7_6)
    (isUp p8_7 p7_7)
    (playerIsAt p5_5)
  )
  (:goal (and
    (boxIsAt p2_3)
    (boxIsAt p4_4)
    (boxIsAt p5_3)
  ))
)
