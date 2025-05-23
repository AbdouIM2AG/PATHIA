(define (problem hanoi-4-peg-standard)
  (:domain hanoi-ff)
  (:objects 
    disk1 disk2 disk3 disk4 - disk
    peg1 peg2 peg3 - peg)
  (:init
    (on disk4 peg1)
    (on disk3 disk4)
    (on disk2 disk3)
    (on disk1 disk2)
    (clear disk1)
    (clear peg2)
    (clear peg3)
    (smaller disk1 disk2)
    (smaller disk1 disk3)
    (smaller disk1 disk4)
    (smaller disk2 disk3)
    (smaller disk2 disk4)
    (smaller disk3 disk4)
  )
  (:goal (and
    (on disk4 peg3)
    (on disk3 disk4)
    (on disk2 disk3)
    (on disk1 disk2)
  ))
)
