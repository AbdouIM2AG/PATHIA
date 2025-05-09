(define (problem hanoi-3-peg-standard)
  (:domain hanoi-ff)
  (:objects 
    disk1 disk2 disk3 - disk
    peg1 peg2 peg3 - peg)
  (:init
    ;; Configuration initiale : disk3 (plus grand) est sur peg1, disk2 sur disk3, puis disk1 sur disk2.
    (on disk3 peg1)
    (on disk2 disk3)
    (on disk1 disk2)
    (clear disk1)
    (clear peg2)
    (clear peg3)
    ;; Relations de taille
    (smaller disk1 disk2)
    (smaller disk1 disk3)
    (smaller disk2 disk3)
  )
  (:goal (and
    (on disk3 peg3)
    (on disk2 disk3)
    (on disk1 disk2)
  ))
)
