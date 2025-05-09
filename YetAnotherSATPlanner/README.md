# 🤖 Planification Automatique avec SAT

Ce projet implémente un planificateur automatique utilisant un encodage SAT afin de résoudre des problèmes de planification. Il encode les problèmes de planification en clauses logiques, puis utilise un solveur SAT pour trouver des plans valides. A utiliser en lançant le script fourni.

---

## 📁 Fichiers importants

YetAnotherSatPlanner/

├── benchmarks # Contient une longue liste de problèmes ainsi que le domaine qui leur est associé

├── classes # contient les classes

├── lib # les bibliothèques

├── src/fr/uga/pddl4j/yasp

│   ├── SATEncoding.java # Encodage SAT des problèmes de planification

│   ├── YetAnotherSATPlanner.java # Définition des problèmes de planification

├── domain.pddl # défini le domaine du problème de planification

├── p01.pddl # défini un problème

├── yetanothersatplanner.sh # script shell pour compiler et exécuter les fichiers


## ⚙️ Prérequis

- Java 11+
- Maven (`mvn`)
- Linux/WSL ou bash pour exécuter les scripts

---

## 🚀 Exécution étape par étape

Vous n'aurez besoin d'utiliser que le script yetnanothersatplanner.sh

1- Dans le terminal, exécuter le script avec la commande ./yetanothersatplanner.sh.

2- Vous verrez un menu apparaitre dans le terminal, qui vous demandera de choisir parmi 3 options en entrant 1, 2 ou 3. Choisissez 1 pour compiler les fichiers.

3- Une fois les fichiers compilés, choisissez l'option 2 et entrez les chemins des fichiers contenant le domaine et le problème à résoudre.
