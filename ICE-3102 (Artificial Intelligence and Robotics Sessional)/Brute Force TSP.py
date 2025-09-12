import itertools

def tsp_bruteforce(n, dist):
    cities = list(range(n))
    min_cost = float("inf")
    best_path = None
    
    # Try all permutations of cities except the starting city (0)
    for perm in itertools.permutations(cities[1:]):
        path = (0,) + perm + (0,)  # start and end at 0
        cost = sum(dist[path[i]][path[i+1]] for i in range(len(path)-1))
        if cost < min_cost:
            min_cost = cost
            best_path = path
    
    return min_cost, best_path

# Example
n = 4
dist = [[0,13,15,20],
        [10,0,35,25],
        [15,45,0,30],
        [20,25,30,0]]

min_cost, path = tsp_bruteforce(n, dist)
print("Minimum cost:", min_cost)
print("Best path:", path)
