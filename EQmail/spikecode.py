import qrcode
from PIL import Image
import numpy as np

def generate_spike_qr(data: str, spike_id: int):
    # Step 1: Generate QR
    qr = qrcode.QRCode(
        version=2,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=1,
    )
    qr.add_data(data)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white")
    
    # Step 2: Save as texture for 3D spike surface
    filename = f"spike_{spike_id}_qr.png"
    img.save(filename)
    return filename

# Example usage: Generate 5 spiked QR faces
data_chunks = ["EQ://data/alpha", "EQ://data/beta", "EQ://data/gamma", "EQ://data/delta", "EQ://data/epsilon"]
for i, chunk in enumerate(data_chunks):
    generate_spike_qr(chunk, i)
