import time

def upload_in_chunks(data, max_chunk_size=5):
    """Simulate uploading data in chunks to avoid size limits."""
    chunks = [data[i:i+max_chunk_size] for i in range(0, len(data), max_chunk_size)]
    for i, chunk in enumerate(chunks, 1):
        print(f"Uploading chunk {i}: {chunk}")
        # Simulate upload delay
        time.sleep(1)
    print("All chunks uploaded successfully!")

# Example usage
sample_data = "This is a sample text that we want to upload, but it's too big for the limit."
upload_in_chunks(sample_data, max_chunk_size=10)

Sent from Proton Mail Android