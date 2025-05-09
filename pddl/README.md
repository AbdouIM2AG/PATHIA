# 🧩 TP Sokoban – Résolution automatique avec PDDL & PDDL4J

Ce projet résout des niveaux de Sokoban automatiquement avec un planificateur PDDL (PDDL4J). Il permet de générer les problèmes, les résoudre et de rejouer les solutions visuellement dans un moteur de jeu.

---

## 📁 Structure du projet

sokoban-master/

├── config/ # Niveaux Sokoban au format JSON (test1.json, etc.)

├── generated_pddl/ # Problèmes PDDL générés automatiquement

├── plans/ # Plans générés par le planificateur

├── solutions_json/ # Plans convertis en JSON (pour moteur)

├── src/ # Moteur Java Sokoban (CodinGame)

├── domain.pddl # Définition des actions et types PDDL

├── generate_test1_pddl.py # JSON → problème PDDL

├── generate_plan.sh # Résolution automatique (PDDL4J)

├── generate_plan_to_json.py # Plan → JSON pour le moteur

├── pddl4j-4.0.0.jar # Planificateur PDDL4J*

├── pom.xml # Dépendances Java via Maven
└── ...


---

## ⚙️ Prérequis

- Python 3
- Java 11+
- Maven (`mvn`)
- Linux/WSL ou bash pour exécuter les scripts

---

## 🚀 Exécution étape par étape

### 1. Génération des fichiers PDDL

```bash
python3 generate_test1_pddl.py
```

→ Crée tous les fichiers problem_XX.pddl dans generated_pddl/

### 2. Résolution automatique avec PDDL4J

```bash
./generate_plan.sh
```
→ Crée tous les fichiers plan_XX.txt dans plans/

### 3. Conversion des plans en JSON (format CodinGame)

```bash
python3 generate_plan_to_json.py
```
→ Résout chaque plan, enregistre les plans dans solutions_json/

### 4. Exécution locale dans le moteur Sokoban (interface graphique)
```bash
java --add-opens java.base/java.lang=ALL-UNNAMED \
     -server -Xms2048m -Xmx2048m \
     -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/test-classes/:target/classes" \
     sokoban.SokobanMain
```


