(define (problem hanoi-3-peg-to-peg2)
  (:domain hanoi-ff)
  (:objects 
    disk1 disk2 disk3 - disk
    peg1 peg2 peg3 - peg)
  (:init
    (on disk3 peg1)
    (on disk2 disk3)
    (on disk1 disk2)
    (clear disk1)
    (clear peg2)
    (clear peg3)
    (smaller disk1 disk2)
    (smaller disk1 disk3)
    (smaller disk2 disk3)
  )
  (:goal (and
    (on disk3 peg2)
    (on disk2 disk3)
    (on disk1 disk2)
  ))
)
