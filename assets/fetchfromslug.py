#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
try fetch a slug (i.e /server-status) from hosts within groups.json
'''

import os
import sys
import json
import requests
import argparse
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(levelname)s %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
    )

oproxies = {
    'http':  'socks5h://127.0.0.1:9050',
    'https': 'socks5h://127.0.0.1:9050'
}

parser = argparse.ArgumentParser(description='🦅 try fetch a slug (i.e /server-status) from hosts within groups.json')
parser.add_argument("slug", help='web path to visit')
args = parser.parse_args()

# open ../groups.json - open as an object
with open('../groups.json', 'r') as f:
    groups = json.load(f)

for group in groups:
    for host in group['locations']:
        if host['slug'].endswith('/'):
            host['slug'] = host['slug'][:-1]
        logging.info('trying "{}"'.format(host['title']) + ' from ' + group['name'])
        try:
            r = requests.get(host['slug'] + str(args.slug), proxies=oproxies, timeout=5)
            if r.status_code == 200:
                print('{} {}'.format(host['title'], r.status_code))
                print(host['slug'] + str(args.slug))
            else:
                logging.debug('{} {}'.format(host['title'], r.status_code))
        except requests.exceptions.RequestException as e:
            logging.error('{} {}'.format(host['title'], 'request exception'))
        except requests.exceptions.ConnectionError:
            logging.error('{} {}'.format(host['title'], 'connection error'))
        except requests.exceptions.Timeout:
            logging.error('{} {}'.format(host['title'], 'timeout'))
        except TypeError:
            logging.error('{} {}'.format(host['title'], 'type error'))
        except OSError:
            logging.error('{} {}'.format(host['title'], 'os error'))