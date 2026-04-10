import cv2
import matplotlib.pyplot as plt

# Load image in grayscale
img = cv2.imread('input.jpg', 0)

# 1. Global Thresholding (Otsu)
_, otsu_thresh = cv2.threshold(img, 0, 255, 
                               cv2.THRESH_BINARY + cv2.THRESH_OTSU)

# 2. Adaptive Thresholding (Mean)
adaptive_mean = cv2.adaptiveThreshold(img, 255,
                                      cv2.ADAPTIVE_THRESH_MEAN_C,
                                      cv2.THRESH_BINARY,
                                      11, 2)

# 3. Adaptive Thresholding (Gaussian)
adaptive_gaussian = cv2.adaptiveThreshold(img, 255,
                                          cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
                                          cv2.THRESH_BINARY,
                                          11, 2)

# Plot results
titles = ['Original Image', 'Otsu Thresholding',
          'Adaptive Mean', 'Adaptive Gaussian']

images = [img, otsu_thresh, adaptive_mean, adaptive_gaussian]

plt.figure(figsize=(10,6))
for i in range(4):
    plt.subplot(2,2,i+1)
    plt.imshow(images[i], cmap='gray')
    plt.title(titles[i])
    plt.axis('off')

plt.tight_layout()
plt.show()

