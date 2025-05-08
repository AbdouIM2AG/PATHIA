#!/usr/bin/env python3
import argparse
import math
import time
import re
import heapq
from collections import deque
from typing import Literal, List

from npuzzle import (
    Solution,
    State,
    Move,
    UP, DOWN, LEFT, RIGHT,
    get_children,
    is_goal,
    is_solution,
    load_puzzle,
    to_string,
    create_goal
)
from node import Node

BFS, DFS, ASTAR = 'bfs', 'dfs', 'astar'
Algorithm = Literal['bfs', 'dfs', 'astar']


def solve_bfs(open_list: List[Node]) -> Solution:
    """BFS FIFO en O(1) grâce à deque."""
    dimension = int(math.sqrt(len(open_list[0].get_state())))
    moves = [UP, DOWN, LEFT, RIGHT]
    queue = deque(open_list)
    while queue:
        node = queue.popleft()
        if is_goal(node.get_state()):
            return node.get_path()
        for s, m in get_children(node.get_state(), moves, dimension):
            queue.append(Node(state=s, move=m, parent=node, cost=node.cost + 1))
    return []


def solve_dfs(open_list: List[Node]) -> Solution:
    """DFS pur LIFO, détection de cycles par ensemble `visited`."""
    dimension = int(math.sqrt(len(open_list[0].get_state())))
    moves = [UP, DOWN, LEFT, RIGHT]
    rev = {UP: DOWN, DOWN: UP, LEFT: RIGHT, RIGHT: LEFT}
    visited = set()
    stack = open_list.copy()

    while stack:
        node = stack.pop()
        key = tuple(node.get_state())
        if key in visited:
            continue
        visited.add(key)

        if is_goal(node.get_state()):
            path = []
            cur = node
            while cur.parent is not None:
                path.append(cur.move)
                cur = cur.parent
            return list(reversed(path))

        for s, m in reversed(get_children(node.get_state(), moves, dimension)):
            # éviter le mouvement inverse immédiat
            if node.move and m == rev[node.move]:
                continue
            sk = tuple(s)
            if sk not in visited:
                stack.append(Node(state=s, move=m, parent=node, cost=node.cost + 1))

    return []


def manhattan(state: State) -> int:
    """Somme des distances de Manhattan de chaque tuile."""
    n = int(math.sqrt(len(state)))
    goal = create_goal(n)
    h = 0
    for idx, tile in enumerate(state):
        if tile == 0:
            continue
        gr, gc = divmod(tile, n)
        cr, cc = divmod(idx,   n)
        h += abs(gr - cr) + abs(gc - cc)
    return h


def solve_astar(open_list: List[Node]) -> Solution:
    """A* avec f = g + h (Manhattan) et tas (heapq)."""
    root = open_list[0]
    dimension = int(math.sqrt(len(root.get_state())))
    moves = [UP, DOWN, LEFT, RIGHT]

    open_heap = []
    counter = 0
    root.heuristic = manhattan(root.get_state())
    heapq.heappush(open_heap, (root.cost + root.heuristic, counter, root))
    closed = set()

    while open_heap:
        _, _, node = heapq.heappop(open_heap)
        key = tuple(node.get_state())
        if key in closed:
            continue
        if is_goal(node.get_state()):
            return node.get_path()
        closed.add(key)

        for s, m in get_children(node.get_state(), moves, dimension):
            sk = tuple(s)
            if sk in closed:
                continue
            child = Node(state=s, move=m, parent=node, cost=node.cost + 1)
            child.heuristic = manhattan(s)
            counter += 1
            heapq.heappush(open_heap, (child.cost + child.heuristic, counter, child))

    return []


def main():
    parser = argparse.ArgumentParser(description='Solve an n-puzzle.')
    parser.add_argument('filename', help='Puzzle file (.txt)')
    parser.add_argument('-a', '--algo',
                        choices=[BFS, DFS, ASTAR],
                        required=True,
                        help='Algorithm: bfs, dfs or astar')
    parser.add_argument('-v', '--verbose',
                        action='store_true',
                        help='Print the puzzle before solving')
    args = parser.parse_args()

    puzzle = load_puzzle(args.filename)
    if args.verbose:
        print("Initial puzzle:")
        print(to_string(puzzle))

    if is_goal(puzzle):
        print("Puzzle is already solved")
        return

    root = Node(state=puzzle, move=None)
    start = time.time()

    if args.algo == BFS:
        print("=== BFS ===")
        solution = solve_bfs([root])

    elif args.algo == DFS:
        print("=== DFS ===")
        solution = solve_dfs([root])

    else:  # ASTAR
        print("=== A* (Manhattan) ===")
        solution = solve_astar([root])

    duration = time.time() - start

    if solution:
        print("Solution:", solution)
        print("Valid solution:", is_solution(puzzle, solution))
        print("Makespan:", len(solution))
        print(f"Duration: {duration:.4f} s")
    else:
        print("No solution found")

if __name__ == '__main__':
    main()
