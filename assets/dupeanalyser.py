#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import json

# open posts.json
with open('posts.json', 'r') as f:
    posts = json.load(f)

# print each post_title
for post in posts:
    # print any duplicate post_titles
    if posts.count(post) > 1:
        print(post['post_title'])
    
