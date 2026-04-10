import cv2
import numpy as np
import matplotlib.pyplot as plt

# Load image in grayscale
img = cv2.imread('input.jpg', 0)

# Apply histogram equalization
equalized = cv2.equalizeHist(img)

# Plot images
plt.figure(figsize=(10,5))

plt.subplot(2,2,1)
plt.imshow(img, cmap='gray')
plt.title('Original Image')
plt.axis('off')

plt.subplot(2,2,2)
plt.imshow(equalized, cmap='gray')
plt.title('Equalized Image')
plt.axis('off')

# Plot histograms
plt.subplot(2,2,3)
plt.hist(img.ravel(), bins=256, range=[0,256]) # type: ignore
plt.title('Original Histogram')

plt.subplot(2,2,4)
plt.hist(equalized.ravel(), bins=256, range=[0,256]) # type: ignore
plt.title('Equalized Histogram')

plt.tight_layout()
plt.show()
