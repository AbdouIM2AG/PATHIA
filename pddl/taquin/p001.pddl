;; problem-taquin-3x3-ex1.pddl
(define (problem taquin-3x3)
  (:domain taquin-ff)
  (:objects
     blank tile1 tile2 tile3 tile4 tile5 tile6 tile7 tile8 - tile
     p11 p12 p13 p21 p22 p23 p31 p32 p33         - position
  )
  (:init
     ;; configuration initiale (exemple TP1)
     (at tile2 p11) (at tile8 p12) (at tile3 p13)
     (at tile1 p21) (at tile6 p22) (at tile4 p23)
     (at tile7 p31) (at blank p32)(at tile5 p33)
     (empty p32)

     ;; toutes les autres cases sont implicitement non‐vides ou non‐remplies
     ;; (empty p11) etc. ne sont pas nécessaires puisqu'on utilise negative-preconditions

     ;; relations d’adjacence (cases voisines horizontales & verticales)
     (adjacent p11 p12) (adjacent p12 p11)
     (adjacent p12 p13) (adjacent p13 p12)
     (adjacent p21 p22) (adjacent p22 p21)
     (adjacent p22 p23) (adjacent p23 p22)
     (adjacent p31 p32) (adjacent p32 p31)
     (adjacent p32 p33) (adjacent p33 p32)

     (adjacent p11 p21) (adjacent p21 p11)
     (adjacent p12 p22) (adjacent p22 p12)
     (adjacent p13 p23) (adjacent p23 p13)
     (adjacent p21 p31) (adjacent p31 p21)
     (adjacent p22 p32) (adjacent p32 p22)
     (adjacent p23 p33) (adjacent p33 p23)
  )
  (:goal (and
     (at tile1 p11) (at tile2 p12) (at tile3 p13)
     (at tile4 p21) (at tile5 p22) (at tile6 p23)
     (at tile7 p31) (at tile8 p32) (at blank p33)
  ))
)
