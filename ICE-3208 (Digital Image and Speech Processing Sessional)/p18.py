import cv2
import pywt
import numpy as np
import matplotlib.pyplot as plt

# Load image in grayscale
img = cv2.imread('strawberry.jpg', 0)

# Perform 2-level DWT
coeffs = pywt.wavedec2(img, 'haar', level=2)

# Extract coefficients
LL2, (LH2, HL2, HH2), (LH1, HL1, HH1) = coeffs

# Plot results
plt.figure(figsize=(10,8))

plt.subplot(3,3,1)
plt.imshow(img, cmap='gray')
plt.title('Original Image')
plt.axis('off')

# Level 1
plt.subplot(3,3,2)
plt.imshow(LH1, cmap='gray')
plt.title('LH1 (Horizontal)')
plt.axis('off')

plt.subplot(3,3,3)
plt.imshow(HL1, cmap='gray')
plt.title('HL1 (Vertical)')
plt.axis('off')

plt.subplot(3,3,4)
plt.imshow(HH1, cmap='gray')
plt.title('HH1 (Diagonal)')
plt.axis('off')

# Level 2
plt.subplot(3,3,5)
plt.imshow(LL2, cmap='gray')
plt.title('LL2 (Approximation)')
plt.axis('off')

plt.subplot(3,3,6)
plt.imshow(LH2, cmap='gray')
plt.title('LH2')

plt.axis('off')

plt.subplot(3,3,7)
plt.imshow(HL2, cmap='gray')
plt.title('HL2')
plt.axis('off')

plt.subplot(3,3,8)
plt.imshow(HH2, cmap='gray')
plt.title('HH2')
plt.axis('off')

plt.tight_layout()
plt.show()
