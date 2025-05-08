# 📂 Organisation du Projet NPuzzle

Ce dépôt contient l’implémentation complète du TP1 **NPuzzle**, avec :
- 🧩 **Génération** de puzzles via un script Python  
- 🤖 **Solveurs** en BFS, DFS et A*  
- 📊 **Analyse** des performances et visualisation dans un **Notebook Jupyter**

---

## 🗂️ Arborescence

npuzzle/

├── pycache/ # Fichiers compilés Python

├── puzzles/ # Jeux de données (.txt)

├── generate_npuzzle.py # Générateur de puzzles

├── solve_npuzzle.py # Solveur (BFS, DFS, A*)

├── solve_all.py # Lance tous les solveurs sur un batch

├── gen_all.sh # Script shell (génération + résolution)

├── analysis.ipynb # ⭐ Notebook Jupyter d’analyse complète


> 💡 **Le cœur de l’analyse** se trouve dans `analysis.ipynb` :  
> mélanges de code, graphiques et explications pour interpréter vos résultats.

---

# 📊 Analyse des Résultats

---

## 1. ⏱️ Temps de résolution  
*(Graphique linéaire par taille)*

### 🔴 BFS  
- 🚀 **Explosion exponentielle**  
  Dès qu’on passe de 6×6 à 7×7, le nombre d’états à visiter explose, d’où la montée brutale du temps moyen.  
- 📉 **Pics & baisses**  
  La chute en 9×9 s’explique par les timeouts : seules les instances les plus rapides sont comptées, biaisant la moyenne vers le bas.

### 🟢 A*  
- ⚖️ **Stabilité**  
  Grâce à l’heuristique de Manhattan, A* cible directement les états prometteurs et garde l’arbre de recherche compact.  
- 📈 **Croissance modérée**  
  En augmentant la taille du puzzle, A* visite un peu plus de nœuds, mais reste sous la dizaine de millisecondes.

### 🔵 DFS  
- ↔️ **Plateau quasi horizontal**  
  DFS n’est ni optimal ni complet avant timeout ; il s’arrête souvent après un nombre fixe d’explorations.  
- 🔀 **Variabilité**  
  On observe de petits pics vers 7×7–8×8 : l’arbre est plus profond, et DFS peut plonger dans des branches très longues avant de revenir.

---

## 2. 📈 Makespan moyen  
*(Scatter plot par taille)*

### 🔴🟢 BFS & A*  
- 🎯 **Solutions optimales**  
  Les deux méthodes trouvent toujours le chemin le plus court ⇒ leurs points sont quasiment superposés.  
- ➗ **Croissance linéaire**  
  On passe de ~2,85 coups en 3×3 à ~3,3 coups en 10×10, car la profondeur de shuffle augmente de façon proportionnelle.

### 🔵 DFS  
- ❌ **Solutions sous‑optimales**  
  DFS tombe souvent sur un chemin plus long qu’optimal.  
- ↕️ **Décalage constant**  
  Son makespan moyen est systématiquement ~0,1–0,2 déplacement au‑dessus de BFS/A*.

---

## 3. 💡 Pourquoi ces résultats ?  
1. **Complexité de l’espace d’états**  
   - Pour un taquin N×N, l’espace de recherche est de l’ordre de (N²)! ; BFS devient très vite ingérable.  
2. **Rôle de l’heuristique**  
   - A* avec l’heuristique de Manhattan guide la recherche vers l’objectif, réduisant drastiquement le nombre de nœuds visités.  
3. **Stratégies non optimales**  
   - DFS explore en profondeur sans tenir compte de la distance à l’objectif, ce qui peut mener à des solutions plus longues ou à des timeouts.  
4. **Effet des timeouts**  
   - **BFS** : seules les exécutions les plus rapides sont comptées → moyenne artificiellement basse sur les grandes tailles.  
   - **DFS** : un timeout fixe borne son temps de résolution maximal, écrasant les écarts naturels.

---


*— Fin de l’analyse —*


