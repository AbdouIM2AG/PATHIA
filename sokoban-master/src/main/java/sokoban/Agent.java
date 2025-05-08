package sokoban;

import java.io.FileReader;
import java.io.IOException;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Agent {
    public static void main(String[] args) {
        String level = System.getenv("LEVEL");
        if (level == null) {
            level = "24";
        }

        String path = "solutions_json/solution_" + level + ".json";
        JSONParser parser = new JSONParser();

        try (FileReader reader = new FileReader(path)) {
            JSONObject json = (JSONObject) parser.parse(reader);
            String solution = (String) json.get("solution");

            if (solution != null && !solution.isEmpty()) {
                // On joue toute la solution
                for (char move : solution.toCharArray()) {
                    System.out.println(move);
                }

                
            } else {
                System.err.println("❌ Aucune solution trouvée pour le niveau " + level);
            }
        } catch (IOException | ParseException e) {
            System.err.println("❌ Erreur : impossible de lire le fichier " + path);
            System.err.println("➡️ Détail : " + e.getMessage());
        }
    }
}
