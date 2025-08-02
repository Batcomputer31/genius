def backrub_rank(web_pages, citations):
    """Original BackRub algorithm concept"""
    ranks = {}
    
    for page in web_pages:
        rank = 0
        for citing_page in citations.get(page, []):
            rank += 1  # Simple citation count
        ranks[page] = rank
    
    return ranks

# Example usage
pages = ["page1", "page2", "page3", "page4"]
citations = {
    "page1": ["page2", "page3"],
    "page2": ["page3"],
    "page3": ["page1"],
    "page4": []
}

results = backrub_rank(pages, citations)
print("BackRub ranks:", results)