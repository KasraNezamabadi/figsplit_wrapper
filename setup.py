from setuptools import setup

setup(
    name='figsplit_wrapper',
    version='1',
    packages=[''],
    python_requires='3.8',
    install_requires=[
        'matlabengine',
      ],
    url='',
    license='',
    author='Kasra Nezamabadi',
    author_email='kasra@udel.edu',
    description='Python wrapper for FigSplit to allow us to run the module locally and cut the dependency on a single deployed API'
)
