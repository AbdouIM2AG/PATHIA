(define (problem hanoi-4-disks-split-initial)
  (:domain hanoi-ff)
  (:objects 
    disk1 disk2 disk3 disk4 - disk
    peg1 peg2 peg3 - peg)
  (:init
    ;; Sur peg1 : disk4 en bas, disk3 sur disk4.
    (on disk4 peg1)
    (on disk3 disk4)
    ;; Sur peg2 : disk2 en bas, disk1 sur disk2.
    (on disk2 peg2)
    (on disk1 disk2)
    (clear disk3)
    (clear disk1)
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
