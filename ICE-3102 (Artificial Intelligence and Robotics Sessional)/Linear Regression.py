X = [1, 2, 3, 4, 5] # Independent variable
Y = [2, 4, 5, 4, 5] # Dependent variable
n = len(X)

# CalculaƟng means
mean_x = sum(X)/n
mean_y = sum(Y)/n

# CalculaƟng slope (m) and intercept (b)
num = sum((X[i]-mean_x)*(Y[i]-mean_y) for i in range(n))
den = sum((X[i]-mean_x)**2 for i in range(n))
m = num / den
b = mean_y - m*mean_x
print(f"Slope (m) = {m}")
print(f"Intercept (b) = {b}")
# PredicƟng values
Y_pred = [m*x + b for x in X]
print("Predicted Y values: ", Y_pred)