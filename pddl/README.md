# README

Ce dépôt contient des domaines PDDL et leurs problèmes pour plusieurs classiques de la planification, notamment :
----

## Tours de Hanoï avec 3 disques et 3 piquets

domain.pddl

p001.pddl … p010.pddl

 ----
### Sokoban

domain.pddl

p001.pddl … p008.pddl

---

### Taquin (taille 3 * 3)

domain.pddl

p001.pddl … p007.pdd

---

## Exécution des solveurs

### Avec FF

```bash
ff -o domain.pddl -f p001.pddl
```

### Avec PDDL4J (script fourni)

#### Un script pddl4j.sh est inclus à la racine pour lancer PDDL4J plus facilement :

```bash
./pddl4j.sh HSP --domain domain.pddl --problem p001.pddl
```
