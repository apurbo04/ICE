import cv2
import numpy as np
import matplotlib.pyplot as plt
import math

# Load image
img = cv2.imread('input.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Apply thresholding
_, thresh = cv2.threshold(gray, 150, 255, cv2.THRESH_BINARY_INV)

# Noise removal
kernel = np.ones((3,3), np.uint8)
thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)

# Find contours
contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Sort contours left to right
contours = sorted(contours, key=lambda c: cv2.boundingRect(c)[0])

char_images = []
output = img.copy()

for cnt in contours:
    x, y, w, h = cv2.boundingRect(cnt)

    if w > 10 and h > 10:
        char = thresh[y:y+h, x:x+w]
        char_images.append(char)

        cv2.rectangle(output, (x, y), (x+w, y+h), (0, 255, 0), 2)

# Main figure
plt.figure(figsize=(12,6))

plt.subplot(1,2,1)
plt.imshow(cv2.cvtColor(output, cv2.COLOR_BGR2RGB))
plt.title("Detected Characters")
plt.axis('off')

plt.subplot(1,2,2)
plt.imshow(thresh, cmap='gray')
plt.title("Binary Image")
plt.axis('off')

plt.tight_layout()
plt.show()

# Plot all segmented characters together with labels on right side
num_chars = len(char_images)
cols = 5
rows = math.ceil(num_chars / cols)

plt.figure(figsize=(15, 3*rows))

for i, char in enumerate(char_images):
    ax = plt.subplot(rows, cols, i+1)
    ax.imshow(char, cmap='gray')
    ax.axis('off')

    # Add title/label on right side
    ax.text(
        1.05, 0.5,
        f'Char {i+1}',
        transform=ax.transAxes,
        fontsize=10,
        va='center'
    )

plt.tight_layout()
plt.show()