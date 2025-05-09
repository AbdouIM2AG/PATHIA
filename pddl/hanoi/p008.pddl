(define (problem hanoi-3-disks-mixed-initial)
  (:domain hanoi-ff)
  (:objects 
    disk1 disk2 disk3 - disk
    peg1 peg2 peg3 - peg)
  (:init
    ;; Configuration initiale mixte :
    ;; - disk3 est sur peg1 avec disk2 empilé dessus.
    ;; - disk1 est posé directement sur peg2.
    (on disk3 peg1)
    (on disk2 disk3)
    (on disk1 peg2)
    (clear disk2)   ; disk2 est libre (rien au-dessus)
    (clear disk1)
    (clear peg3)
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
