'''
Primer loging skripte za potrebe na UL, ko sem potreboval na katerem pathu se nahajam ob script runtime. 
Skripta logira pot npr. "/home/anze/Documents/GIT/UserLane_GIThub_Repo/service-analytics-steperrors-spark" 
in zapiše v path.log datoteko
'''

import logging
import os

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger()
logger.addHandler(logging.FileHandler('path.log', 'a'))
print = logger.info

print(os.getcwd())