#!/usr/bin/python3
"""1-top-ten module"""
import requests


def top_ten(subreddit):
    """
    top_ten: prints the titles of the first
    10 hot posts listed for a given subreddit.
    Args:
        subreddit: passed to the url
    """
    headers = {'User-Agent': 'My User Agent 1.0'}

    url = f'https://www.reddit.com/r/{subreddit}/hot.json'

    params = {
            "limit": 10,
            }

    r = requests.get(
            url,
            headers=headers,
            params=params,
            allow_redirects=False
            )

    if r.status_code == 200:
        data = r.json()
        results = data.get("data")

        hot_titles = []

        for i in results.get("children"):
            title = i.get('data').get('title')
            hot_titles.append(title)
            print(title)

        return hot_titles
    else:
        print(None)
        return
