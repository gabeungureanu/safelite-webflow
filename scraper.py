import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse

url = 'https://gabriels-fantabulous-site-23ac8b.webflow.io/'

response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# Create directories for downloaded files
os.makedirs('downloaded_files', exist_ok=True)
os.makedirs('downloaded_images', exist_ok=True)

def download_file(url, directory):
    response = requests.get(url)
    filename = urlparse(url).path.split('/')[-1]
    filepath = os.path.join(directory, filename)
    with open(filepath, 'wb') as file:
        file.write(response.content)

# Download images
for img in soup.find_all('img'):
    src = img.get('src')
    if src:
        img_url = urljoin(url, src)
        download_file(img_url, 'downloaded_images')

# Download other files (e.g., PDF, ZIP)
for a in soup.find_all('a'):
    href = a.get('href')
    if href and (href.lower().endswith('.pdf') or href.lower().endswith('.zip')):
        file_url = urljoin(url, href)
        download_file(file_url, 'downloaded_files')
