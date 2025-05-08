#!/bin/bash

DOMAIN_FILE="domain.pddl"
PDDL_DIR="generated_pddl"
PLAN_DIR="plans"
PDDL4J_JAR="pddl4j-4.0.0.jar"
HEURISTIC="5"  # Choisissez la heuristique (exemple : FAST_FORWARD = 5)
TIMEOUT=400

mkdir -p "$PLAN_DIR"

# Fonction pour générer le plan d'un niveau donné
generate_plan() {
    LEVEL_NUM=$1
    PROBLEM_FILE="$PDDL_DIR/problem_${LEVEL_NUM}.pddl"
    OUTPUT_PLAN="$PLAN_DIR/plan_${LEVEL_NUM}.txt"

    if [[ ! -f "$PROBLEM_FILE" ]]; then
        echo "Fichier manquant : $PROBLEM_FILE"
        return 1
    fi

    # Exécution du planificateur
    java -cp "$PDDL4J_JAR" fr.uga.pddl4j.planners.statespace.HSP \
        -e FAST_FORWARD -t "$TIMEOUT" "$DOMAIN_FILE" "$PROBLEM_FILE" > "$OUTPUT_PLAN" 2>/dev/null

    # Vérifie s'il y a au moins une action push dans le plan généré
    if grep -q "(push" "$OUTPUT_PLAN"; then
        # Enlever les espaces inutiles devant 'pmove' et 'push' (et aussi bien traiter les autres espaces)
        sed -i 's/ pmove/pmove/g' "$OUTPUT_PLAN"
        sed -i 's/ push/push/g' "$OUTPUT_PLAN"
        echo " Plan généré pour le niveau $LEVEL_NUM : $OUTPUT_PLAN"
    else
        echo "Aucun plan trouvé pour le niveau $LEVEL_NUM"
        rm -f "$OUTPUT_PLAN"  # Optionnel : supprime les plans vides
        return 1
    fi
}

# Générer les plans pour tous les niveaux de 1 à 30
for i in $(seq 1 30); do
    LEVEL_NUM=$(printf "%02d" "$i")
    echo " Résolution niveau $LEVEL_NUM..."

    # Appeler la fonction pour générer le plan
    generate_plan "$LEVEL_NUM"
done

echo " Tous les niveaux ont été traités."
