from functools import lru_cache
INF = 10**9
def tsp(n, dist):
    @lru_cache(None)
    def solve(mask, pos):
        if mask == (1<<n) - 1:
            return dist[pos][0]  # back to start
        
        ans = INF
        for city in range(n):
            if not (mask & (1<<city)):
                ans = min(ans, dist[pos][city] + solve(mask | (1<<city), city))
        return ans 
    return solve(1, 0) 

# Example
n = 4
dist = [[0,13,15,20],
        [10,0,35,25],
        [15,45,0,30],
        [20,25,30,0]]
print("Minimum cost:", tsp(n, dist))
