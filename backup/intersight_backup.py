#!/usr/bin/env python3
import requests
import json

from intersight_auth import IntersightAuth


def get_object(url):
    """
    Function to make HTTP GET API calls to Intersight and return response in json.
    """
    auth = IntersightAuth(
        secret_key_filename="./SecretKey.txt",
        api_key_id="<replace_with_api_key_id>"
        # api_key_id=os.getenv("api_key_id"),
    )
    payload = {}
    headers = {"Accept": "application/json"}
    response = requests.request("GET", url, auth=auth, headers=headers, data=payload)
    return response.json()


def get_urls(filename):
    """
    Function to load file with Intersight URL's.
    """
    with open(filename, "r") as f:
        urls = json.load(f)
    return urls


if __name__ == "__main__":
    intersight_objects = {}

    # Load URL file
    url_file = "intersight_urls.json"
    urls = get_urls(url_file)

    # Make API calls to all the URL's
    for key, value in urls.items():
        print(key)
        response = get_object(urls[key])
        intersight_objects[key] = response["Results"]

    # Write response to a json.
    with open("intersight_objects.json", "w") as f:
        json.dump(intersight_objects, f)
    # print(intersight_objects)
