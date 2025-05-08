import os
import json
import re

# Répertoires utilisés
plans_dir = "plans"
solutions_dir = "solutions_json"
os.makedirs(solutions_dir, exist_ok=True)

# Dictionnaire de correspondance entre le nom de la direction et la lettre attendue
dir_map = {
    "down": "D",
    "up": "U",
    "left": "L",
    "right": "R"
}

def parse_pos(pos):
    """
    Extrait les coordonnées de la position sous forme de tuple (y, x).
    Exemple : "p2_4" → (2, 4)
    """
    match = re.match(r"p(\d+)_(\d+)", pos)
    if not match:
        raise ValueError(f"Format de position invalide : {pos}")
    return tuple(map(int, match.groups()))

def convert_plan_to_json(plan_path, level):
    """
    Convertit un fichier de plan PDDL modifié en un fichier JSON contenant
    la séquence de directions sous forme de lettres.
    """
    if not os.path.isfile(plan_path):
        print(f"Plan manquant : {plan_path}")
        return

    moves = []
    with open(plan_path, "r") as f:
        for line in f:
            # Reconnaissance des actions push, ex: (push-down p2_4 p3_4 p4_4)
            match_push = re.search(
                r".*\(\s*push-(down|up|left|right)\s+(p\d+_\d+)\s+(p\d+_\d+)\s+(p\d+_\d+)\)",
                line,
                re.IGNORECASE
            )
            # Reconnaissance des actions move, ex: (move-left p4_4 p4_3)
            match_move = re.search(
                r".*\(\s*move-(down|up|left|right)\s+(p\d+_\d+)\s+(p\d+_\d+)\)",
                line,
                re.IGNORECASE
            )
            
            if match_push:
                direction_word = match_push.group(1).lower()
                moves.append(dir_map.get(direction_word, "?"))
                print(f"Push action détectée : direction {direction_word.upper()}")
            elif match_move:
                direction_word = match_move.group(1).lower()
                moves.append(dir_map.get(direction_word, "?"))
                print(f"Move action détectée : direction {direction_word.upper()}")
    
    solution_data = {
        "level": int(level),
        "solution": "".join(moves)
    }
    
    output_path = os.path.join(solutions_dir, f"solution_{level}.json")
    with open(output_path, "w") as out:
        json.dump(solution_data, out, indent=2)
    print(f"Solution enregistrée : {output_path}")

# Parcours de tous les fichiers plan_XX.txt du répertoire plans
for filename in sorted(os.listdir(plans_dir)):
    if filename.startswith("plan_") and filename.endswith(".txt"):
        level = filename.replace("plan_", "").replace(".txt", "")
        convert_plan_to_json(os.path.join(plans_dir, filename), level)

print("Tous les plans ont été convertis en JSON.")
