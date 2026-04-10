import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage import measure

# Load image
img = cv2.imread('rice.tiff', 0)

# Apply thresholding (Otsu)
_, thresh = cv2.threshold(img, 0, 255, 
                          cv2.THRESH_BINARY + cv2.THRESH_OTSU)

# Invert if necessary (rice should be white)
thresh = cv2.bitwise_not(thresh)

# Remove noise using morphological opening
kernel = np.ones((3,3), np.uint8)
clean = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, kernel)

# Label connected components
labels = measure.label(clean, connectivity=2)

# Get properties
properties = measure.regionprops(labels)

# Count rice grains
rice_count = len(properties)
print("Total number of rice grains:", rice_count)

# Lists to store features
areas = []
perimeters = []
major_axes = []

for prop in properties:
    areas.append(prop.area)
    perimeters.append(prop.perimeter)
    major_axes.append(prop.major_axis_length)

# Display properties
for i, prop in enumerate(properties):
    print(f"Rice {i+1}: Area={prop.area}, "
          f"Perimeter={prop.perimeter:.2f}, "
          f"Major Axis Length={prop.major_axis_length:.2f}")

# Filter by specific area range
min_area = 100
max_area = 1000

filtered = [prop for prop in properties if min_area <= prop.area <= max_area]
print("\nRice grains within area range:", len(filtered))

# Plot labeled image
plt.figure(figsize=(6,6))
plt.imshow(labels, cmap='nipy_spectral')
plt.title("Labeled Rice Grains")
plt.axis('off')
plt.show()
