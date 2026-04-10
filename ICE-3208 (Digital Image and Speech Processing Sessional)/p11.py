import cv2
import numpy as np
import matplotlib.pyplot as plt

# Load image
img = cv2.imread('input.jpg')
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# Function to add Gaussian noise
def add_gaussian_noise(image):
    mean = 0
    sigma = 25
    gaussian = np.random.normal(mean, sigma, image.shape).astype('uint8')
    noisy = cv2.add(image, gaussian)
    return noisy

# Function to add Salt & Pepper noise
def add_salt_pepper_noise(image):
    noisy = np.copy(image)
    prob = 0.02

    # Salt
    num_salt = np.ceil(prob * image.size * 0.5)
    coords = [np.random.randint(0, i - 1, int(num_salt)) for i in image.shape]
    noisy[tuple(coords)] = 255

    # Pepper
    num_pepper = np.ceil(prob * image.size * 0.5)
    coords = [np.random.randint(0, i - 1, int(num_pepper)) for i in image.shape]
    noisy[tuple(coords)] = 0

    return noisy

# Add noise
gaussian_noisy = add_gaussian_noise(img)
sp_noisy = add_salt_pepper_noise(img)

# Apply filters
mean_gaussian = cv2.blur(gaussian_noisy, (5,5))
mean_sp = cv2.blur(sp_noisy, (5,5))

gauss_gaussian = cv2.GaussianBlur(gaussian_noisy, (5,5), 0)
gauss_sp = cv2.GaussianBlur(sp_noisy, (5,5), 0)

# Show results
titles = ['Original', 'Gaussian Noise', 'Mean Filter', 'Gaussian Filter',
          'Salt & Pepper Noise', 'Mean Filter', 'Gaussian Filter']

images = [img, gaussian_noisy, mean_gaussian, gauss_gaussian,
          sp_noisy, mean_sp, gauss_sp]

plt.figure(figsize=(12,8))
for i in range(len(images)):
    plt.subplot(3,3,i+1)
    plt.imshow(images[i])
    plt.title(titles[i])
    plt.axis('off')

plt.tight_layout()
plt.show()
