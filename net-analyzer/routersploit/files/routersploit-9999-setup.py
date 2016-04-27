from setuptools import setup, find_packages

setup(
    name='routersploit',
    packages=find_packages(exclude=['routersploit.test']),
    install_requires=[
        'beautifulsoup4',
        'gnureadline',
        'paramiko',
        'requests',
    ],
    scripts=['rsf.py'],
)
