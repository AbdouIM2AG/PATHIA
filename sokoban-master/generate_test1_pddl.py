import os
import json

# Dossier source et de sortie
json_dir = "config"
pddl_output_dir = "generated_pddl"
os.makedirs(pddl_output_dir, exist_ok=True)

directions = [
    ("left", 0, -1),
    ("right", 0, 1),
    ("up", -1, 0),
    ("down", 1, 0),
]

def pos_name(row, col):
    return f"p{row+1}_{col+1}"

def is_wall(grid, r, c, num_rows, num_cols):
    # Considère hors grille comme mur
    if r < 0 or r >= num_rows or c < 0 or c >= num_cols:
        return True
    return grid[r][c] == "#"

def convert_testin_to_pddl(json_path, pddl_path, level_num):
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    grid_lines = data["testIn"].strip().split("\n")
    num_rows = len(grid_lines)
    num_cols = max(len(line) for line in grid_lines)
    grid = [line.ljust(num_cols) for line in grid_lines]

    objects = set()
    init = []
    goals = []

    # Remplir les faits initiaux et l'ensemble des objets
    for r, row in enumerate(grid):
        for c, cell in enumerate(row):
            name = pos_name(r, c)
            if cell in " @+$*.":
                objects.add(name)
                if cell == " ":
                    init.append(f"(isEmpty {name})")
                elif cell == "@":
                    init.append(f"(playerIsAt {name})")
                elif cell == ".":
                    init.append(f"(isEmpty {name})")
                    goals.append(f"(boxIsAt {name})")
                elif cell == "$":
                    init.append(f"(boxIsAt {name})")
                elif cell == "+":
                    init.append(f"(playerIsAt {name})")
                    goals.append(f"(boxIsAt {name})")
                elif cell == "*":
                    init.append(f"(boxIsAt {name})")
                    goals.append(f"(boxIsAt {name})")

    # Ajout des faits d'adjacence
    for r in range(num_rows):
        for c in range(num_cols):
            from_name = pos_name(r, c)
            for dname, dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < num_rows and 0 <= nc < num_cols:
                    to_name = pos_name(nr, nc)
                    if grid[r][c] != "#" and grid[nr][nc] != "#":
                        init.append(f"(is{dname.capitalize()} {from_name} {to_name})")

    # Détection des positions en impasse (deadlock)
    # On considère qu'une case non-but est en impasse si elle est dans un coin (deux voisins perpendiculaires sont des murs)
    for r, row in enumerate(grid):
        for c, cell in enumerate(row):
            name = pos_name(r, c)
            # On ne traite que les cases exploitables mais non marquées comme buts
            if cell in " @$" and cell not in ".+*":
                north = is_wall(grid, r-1, c, num_rows, num_cols)
                south = is_wall(grid, r+1, c, num_rows, num_cols)
                left = is_wall(grid, r, c-1, num_rows, num_cols)
                right = is_wall(grid, r, c+1, num_rows, num_cols)
                # Si la case est dans un coin (deux murs perpendiculaires)
                if (north and left) or (north and right) or (south and left) or (south and right):
                    init.append(f"(deadlock {name})")

    # Génération du contenu PDDL
    with open(pddl_path, "w", encoding="utf-8") as f:
        f.write(f"; testIn for level {level_num}\n")
        f.write(f"(define (problem Sokoban{level_num})\n")
        f.write("  (:domain Sokoban)\n")
        f.write("  (:objects\n    " + " ".join(sorted(objects)) + " - place\n  )\n")
        f.write("  (:init\n")
        for i in sorted(init):
            f.write(f"    {i}\n")
        f.write("  )\n")
        f.write("  (:goal (and\n")
        for g in sorted(goals):
            f.write(f"    {g}\n")
        f.write("  ))\n")
        f.write(")\n")

    print(f" PDDL généré : {pddl_path}")

if __name__ == "__main__":
    for filename in sorted(os.listdir(json_dir)):
        if filename.startswith("test") and filename.endswith(".json"):
            level_number = int(filename.replace("test", "").replace(".json", ""))
            json_path = os.path.join(json_dir, filename)
            pddl_path = os.path.join(pddl_output_dir, f"problem_{level_number:02d}.pddl")
            convert_testin_to_pddl(json_path, pddl_path, level_number)

    print(" Conversion terminée pour tous les fichiers.")
