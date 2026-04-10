import cv2
import numpy as np
import matplotlib.pyplot as plt

# Load image
img = cv2.imread('input.jpg')
img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Define 3x3 kernel (choose one)
kernel = np.array([[1,1,1],
                   [1,1,1],
                   [1,1,1]]) / 9   # Mean filter

# Apply convolution
output = cv2.filter2D(img, -1, kernel)

# Show results
plt.figure(figsize=(8,4))

plt.subplot(1,2,1)
plt.imshow(img, cmap='gray')
plt.title('Original Image')
plt.axis('off')

plt.subplot(1,2,2)
plt.imshow(output, cmap='gray')
plt.title('After Convolution')
plt.axis('off')

plt.show()
