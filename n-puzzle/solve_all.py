#!/usr/bin/env python3
import os
import subprocess
import argparse
import csv
import sys
from subprocess import TimeoutExpired

def main():
    parser = argparse.ArgumentParser(
        description="Batch solve n-puzzles and collect makespan & times."
    )
    parser.add_argument('puzzledir', help='directory containing npuzzle_*.txt')
    parser.add_argument('-a','--algo',
                        choices=['bfs','dfs','astar'],
                        default='astar',
                        help='algorithm to use')
    parser.add_argument('-t','--timeout',
                        type=int,
                        default=60,
                        help='per-puzzle timeout in seconds (default: 60)')
    args = parser.parse_args()

    # Where to write solutions and CSV
    puzzle_dir = args.puzzledir
    sol_dir    = os.path.join(puzzle_dir, 'solutions')
    os.makedirs(sol_dir, exist_ok=True)
    summary_csv = os.path.join(sol_dir, f"summary_{args.algo}.csv")

    # Path to the local solve_npuzzle.py
    solver_script = os.path.join(os.path.dirname(__file__), 'solve_npuzzle.py')

    write_header = not os.path.exists(summary_csv)
    with open(summary_csv, 'a', newline='') as csvf:
        writer = csv.writer(csvf)
        if write_header:
            writer.writerow(['puzzle_file','valid','makespan','duration_s'])

        for fn in sorted(os.listdir(puzzle_dir)):
            if not fn.startswith('npuzzle') or not fn.endswith('.txt'):
                continue

            inp_path = os.path.join(puzzle_dir, fn)
            sol_fn   = fn.replace('.txt', f'_{args.algo}_sol.txt')
            sol_path = os.path.join(sol_dir, sol_fn)

            # Invoke the *exact* solver script from this folder
            cmd = [
                sys.executable, 
                solver_script, 
                inp_path, 
                '-a', args.algo
            ]
            try:
                res = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    timeout=args.timeout
                )
                output = res.stdout
                if res.stderr:
                    output += "\n# STDERR #\n" + res.stderr

                # Parse the solver output
                valid = makespan = duration = ''
                for line in output.splitlines():
                    if line.startswith('Valid solution:'):
                        valid = line.split(':',1)[1].strip()
                    elif line.startswith('Makespan:'):
                        makespan = line.split(':',1)[1].strip()
                    elif line.startswith('Duration:'):
                        duration = line.split(':',1)[1].strip().split()[0]

                # Write CSV
                writer.writerow([fn, valid, makespan, duration])

                # Write per‐instance solution file
                with open(sol_path, 'w') as sf:
                    sf.write(output)

                print(f"[{args.algo.upper()}] {fn} → {sol_fn} (valid={valid}, makespan={makespan}, dur={duration}s)")

            except TimeoutExpired:
                # On timeout, écrire une ligne vide
                writer.writerow([fn, 'False', '', ''])
                with open(sol_path, 'w') as sf:
                    sf.write("# TIMEOUT\n")
                print(f"[{args.algo.upper()}][TIMEOUT] {fn} → {sol_fn}")

if __name__ == '__main__':
    main()
