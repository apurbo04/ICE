def print_solution(board):
    for row in board:
        print(" ".join(str(x) for x in row))
    print()

def is_safe(board, row, col, N):
    # Check left side row
    for i in range(col):
        if board[row][i] == 1:
            return False
    
    # Check upper diagonal
    for i, j in zip(range(row, -1, -1), range(col, -1, -1)):
        if board[i][j] == 1:
            return False
    
    # Check lower diagonal
    for i, j in zip(range(row, N, 1), range(col, -1, -1)):
        if board[i][j] == 1:
            return False
    
    return True

def solve_nq_util(board, col, N):
    if col >= N:
        print_solution(board)
        return True
    res = False
    for i in range(N):
        if is_safe(board, i, col, N):
            board[i][col] = 1
            res = solve_nq_util(board, col + 1, N) or res
            board[i][col] = 0  # BACKTRACK
    return res

def solve_nq(N):
    board = [[0]*N for _ in range(N)]
    if not solve_nq_util(board, 0, N):
        print("No solution exists")

# ✅ Take input from user
N = int(input("Enter the value of N (chessboard size): "))
solve_nq(N)
