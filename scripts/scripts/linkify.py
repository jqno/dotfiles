#!/usr/bin/env python3

"""Fetches a page's <title> and turns it into a markdown link"""

import re
import sys
from html.parser import HTMLParser
import requests


def main(url):
    try:
        resp = fetch(url)
    except Exception as ex:
        print(f"Failed: {ex}")
        sys.exit(1)

    if resp.ok:
        title = extract_title(resp.text)
        print(f"[{title}]({url})")
    else:
        print(f"Failed: {resp.status_code}")
        sys.exit(1)


def fetch(url):
    headers = {'User-Agent': 'Googlebot/2.1 (+http://www.google.com/bot.html)'}
    return requests.get(url, headers=headers)


def extract_title(text):
    class Parser(HTMLParser):
        def __init__(self):
            super().__init__()
            self.active = False
            self.title = ""

        def handle_starttag(self, tag, attrs):
            if tag == "title":
                self.active = True

        def handle_endtag(self, tag):
            if tag == "title":
                self.active = False

        def handle_data(self, data):
            if self.active and self.title == "":
                self.title = data

        def error(self, message):
            print(f"Error: {message}")
            sys.exit(1)

    parser = Parser()
    parser.feed(text)
    return re.sub("\s{2,}", " ", parser.title).strip()


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Expected a url argument")
        sys.exit(1)
    main(sys.argv[1])
