package fr.uga.pddl4j.yasp;

import fr.uga.pddl4j.plan.Plan;
import fr.uga.pddl4j.plan.SequentialPlan;
import fr.uga.pddl4j.problem.Fluent;
import fr.uga.pddl4j.problem.Problem;
import fr.uga.pddl4j.problem.operator.Action;
import fr.uga.pddl4j.problem.operator.Condition;
import fr.uga.pddl4j.problem.operator.Effect;
import fr.uga.pddl4j.util.BitVector;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Arrays;

/**
 * This class implements a planning problem/domain encoding into DIMACS
 *
 * @author H. Fiorino
 * @version 0.1 - 30.03.2024
 */
public final class SATEncoding {

    private final Problem problem;
    /*
     * A SAT problem in dimacs format is a list of int list a.k.a clauses
     */
    private List<List<Integer>> initList = new ArrayList<List<Integer>>();

    /*
     * Goal
     */
    private List<Integer> goalList = new ArrayList<Integer>();

    /*
     * Actions
     */
    private List<List<Integer>> actionPreconditionList = new ArrayList<List<Integer>>();
    private List<List<Integer>> actionEffectList = new ArrayList<List<Integer>>();

    /*
     * State transistions
     */
    private HashMap<Integer, List<Integer>> addList = new HashMap<Integer, List<Integer>>();
    private HashMap<Integer, List<Integer>> delList = new HashMap<Integer, List<Integer>>();
    private List<List<Integer>> stateTransitionList = new ArrayList<List<Integer>>();

    /*
     * Action disjunctions
     */
    private List<List<Integer>> actionDisjunctionList = new ArrayList<List<Integer>>();

    /*
     * Current DIMACS encoding of the planning domain and problem for #steps steps
     * Contains the initial state, actions and action disjunction
     * Goal is no there!
     */
    public List<List<Integer>> currentDimacs = new ArrayList<List<Integer>>();

    /*
     * Current goal encoding
     */
    public List<Integer> currentGoal = new ArrayList<Integer>();

    /*
     * Current number of steps of the SAT encoding
     */
    private int steps;

    public SATEncoding(Problem problem, int steps) {
        this.problem = problem;
        this.steps = steps;
        final int nbFluents = problem.getFluents().size();
        final BitVector init = problem.getInitialState().getPositiveFluents();
        for (int i = 0; i < nbFluents; i++) {
            if (init.get(i)) {
                initList.add(Arrays.asList(pair(i + 1, 1)));
            }
        }
        encode(1, steps);
    }

    /*
     * SAT encoding for next step
     */
    public void next() {
        this.steps++;
        encode(this.steps, this.steps);
    }

    public Plan extractPlan(final List<Integer> solution, final Problem problem) {
        Plan plan = new SequentialPlan();
        HashMap<Integer, Action> seq = new HashMap<>();
        final int nbFluents = problem.getFluents().size();
        List<Action> actions = problem.getActions();
        for (Integer lit : solution) {
            int var = lit > 0 ? lit : -lit;
            int[] pr = unpair(var);
            int id = lit > 0 ? pr[0] : -pr[0];
            int step = pr[1];
            if (id > nbFluents) {
                Action act = actions.get(id - nbFluents - 1);
                seq.put(step, act);
            }
        }
        for (int s = 1; s <= seq.size(); s++) {
            plan.add(s - 1, seq.get(s));
        }
        return plan;
    }

    // Cantor paring function generates unique numbers
    private static int pair(int num, int step) {
        return (int) (0.5 * (num + step) * (num + step + 1) + step);
    }

    private static int[] unpair(int z) {
        /*
        Cantor unpair function is the reverse of the pairing function. It takes a single input
        and returns the two corespoding values.
        */
        int t = (int) ((Math.sqrt(8 * z + 1) - 1) / 2);
        int bitnum = t * (t + 3) / 2 - z;
        int step = z - t * (t + 1) / 2;
        return new int[]{bitnum, step};
    }

    public String toString(final List<Integer> clause, final Problem problem) {
        final int nbFluents = problem.getFluents().size();
        List<Integer> seen = new ArrayList<>();
        StringBuilder repr = new StringBuilder("[");
        StringBuilder details = new StringBuilder();
        int count = 1;
        List<Action> actions = problem.getActions();

        for (Integer lit : clause) {
            int var = lit > 0 ? lit : -lit;
            int[] pr = unpair(var);
            int id = lit > 0 ? pr[0] : -pr[0];
            int st = pr[1];
            repr.append("(").append(id).append(", ").append(st).append(")")
                .append(count++ == clause.size() ? "]\n" : " + ");
            if (!seen.contains(Math.abs(id))) {
                seen.add(Math.abs(id));
                details.append(Math.abs(id)).append(" >> ");
                if (Math.abs(id) <= nbFluents) {
                    Fluent f = problem.getFluents().get(Math.abs(id) - 1);
                    details.append(problem.toString(f)).append("\n");
                } else {
                    Action a = actions.get(Math.abs(id) - nbFluents - 1);
                    details.append(problem.toShortString(a)).append("\n");
                }
            }
        }
        return repr.append(details).toString();
    }

   private void encode(int from, int to) {

        this.currentDimacs.clear();
        currentDimacs.addAll(initList);
        final int nbFluents = problem.getFluents().size();
        List<Action> actions = problem.getActions();

        for (int step = from; step <= to; step++) {

            for (int index = 0; index < actions.size(); index++) {

                Action action = actions.get(index);
                int actionVar = nbFluents + index + 1;
                Condition cond = action.getPrecondition();
                BitVector posPre = cond.getPositiveFluents();
                BitVector negPre = cond.getNegativeFluents();

                for (int i = 0; i < nbFluents; i++) {
                    if (posPre.get(i)) {
                        List<Integer> c = new ArrayList<>();
                        c.add(-pair(actionVar, step));          
                        c.add(pair(i+1, step));              
                        actionPreconditionList.add(c);
                        currentDimacs.add(c);
                    }
                }

                for (int i = 0; i < nbFluents; i++) {
                    if (negPre.get(i)) {
                        List<Integer> c = new ArrayList<>();
                        c.add(-pair(actionVar, step));          
                        c.add(-pair(i+1,step));              
                        actionPreconditionList.add(c);
                        currentDimacs.add(c);
                    }
                }

                Effect effet = action.getUnconditionalEffect();
                BitVector effetPos = effet.getPositiveFluents();
                BitVector effetNeg = effet.getNegativeFluents();

                for (int i = 0; i < nbFluents; i++) {
                    if (effetPos.get(i)) {
                    List<Integer> c = new ArrayList<>();
                        c.add(-pair(actionVar, step));          
                        c.add(pair(i+1, step+1));         
                        actionEffectList.add(c);
                        currentDimacs.add(c);
                    }
                }
                
                for (int i = 0; i < nbFluents; i++) {
                    if (effetNeg.get(i)) {
                        List<Integer> c = new ArrayList<>();
                        c.add(-pair(actionVar, step));          
                        c.add(-pair(i+1, step+1));         
                        actionEffectList.add(c);
                        currentDimacs.add(c);
                    }

                }
            }

            for (int i = 0; i < nbFluents; i++) {
                List<Integer> c = new ArrayList<>();
                c.add(-pair(i+1, step));                  
                c.add(pair(i+1,step+1));               
                stateTransitionList.add(c);
                currentDimacs.add(c);

            for (int ai = 0; ai < actions.size(); ai++) {
                Action action = actions.get(ai);
                int actionVar = nbFluents+ai + 1;
                Effect effet = action.getUnconditionalEffect();
                BitVector effetPos = effet.getPositiveFluents();
                BitVector effetNeg = effet.getNegativeFluents();

                if (effetPos.get(i) || effetNeg.get(i)) {
                    List<Integer> negCl = new ArrayList<>();
                    negCl.add(pair(actionVar, step));     
                    negCl.add(-pair(i+1,step));      
                    negCl.add(-pair(i+1, step+1));  
                    currentDimacs.add(negCl);
                }
            }
        }

            List<Integer> disj = new ArrayList<>();
            for (int i = 0; i < actions.size(); i++) 
                disj.add(pair(nbFluents+i+1,step));
            actionDisjunctionList.add(disj);
            currentDimacs.add(disj);
        }

        currentGoal.clear();
        Condition goalCond = problem.getGoal();
        BitVector posGoal = goalCond.getPositiveFluents();

        for (int i = 0; i < nbFluents; i++) {
            if (posGoal.get(i)) 
                currentGoal.add(pair(i+1, to));       
        }

        int totalClauses = this.currentDimacs.size() + this.currentGoal.size();
        System.out.println("Encoding : successfully done (" + (this.currentDimacs.size()
                + this.currentGoal.size()) + " clauses, " + to + " steps)");

    }

}