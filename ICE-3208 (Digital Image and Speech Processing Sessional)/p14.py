import cv2
import numpy as np
import matplotlib.pyplot as plt

# Load image in grayscale
img = cv2.imread('input.jpg', 0)

# Sobel Edge Detection
sobelx = cv2.Sobel(img, cv2.CV_64F, 1, 0, ksize=3)
sobely = cv2.Sobel(img, cv2.CV_64F, 0, 1, ksize=3)
sobel = cv2.magnitude(sobelx, sobely)

# Prewitt Edge Detection (manual kernels)
kernelx = np.array([[-1,0,1],[-1,0,1],[-1,0,1]])
kernely = np.array([[-1,-1,-1],[0,0,0],[1,1,1]])

prewittx = cv2.filter2D(img, -1, kernelx)
prewitty = cv2.filter2D(img, -1, kernely)
prewitt = np.sqrt(prewittx**2 + prewitty**2)

# Canny Edge Detection
canny = cv2.Canny(img, 100, 200)

# Plot results
titles = ['Original Image', 'Sobel Edge', 'Prewitt Edge', 'Canny Edge']
images = [img, sobel, prewitt, canny]

plt.figure(figsize=(10,6))
for i in range(4):
    plt.subplot(2,2,i+1)
    plt.imshow(images[i], cmap='gray')
    plt.title(titles[i])
    plt.axis('off')

plt.tight_layout()
plt.show()
