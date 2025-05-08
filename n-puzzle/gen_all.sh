#!/usr/bin/env bash
set -euo pipefail

# Répertoires
PUZZLE_DIR="puzzles"
SOL_DIR="$PUZZLE_DIR/solutions"

# 1) Génération
echo "=== Génération des puzzles ==="
mkdir -p "$PUZZLE_DIR"
for size in {3..10}; do
  for depth in {1..10}; do
    num=$(( depth * 10 ))
    echo "  • ${size}×${size}, profondeur ${depth} → ${num} puzzles"
    python3 generate_npuzzle.py \
      -s "$size" \
      -ml "$depth" \
      -n "$num" \
      "$PUZZLE_DIR"
  done
done

# 2) Résolution batch & collecte des stats
echo
echo "=== Résolution et collecte des métriques ==="
mkdir -p "$SOL_DIR"
for algo in bfs dfs astar; do
  echo "  § Algorithme : ${algo^^}"
  # On vide l'ancien résumé (pour pas concaténer à l'infini)
  rm -f "$SOL_DIR/summary_${algo}.csv"
  python3 solve_all.py "$PUZZLE_DIR" -a "$algo"
done

echo
echo "==> Terminé !"
echo "Les fichiers summary_<algo>.csv sont dans : $SOL_DIR"
