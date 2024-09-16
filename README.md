# openformat-to-obj
## Forked Changes

- Outputs obj/mtl to "output" directory for ease of automated testing
- Formats paths differently for Non Windows OS
- Uses glob instead of glob2 module for python 3.11 and 3.12 compatibility

## Running tests

I am concerned about the changes I made breaking backwards Python 3 compatibility, but it seems like everything works out well still.
At least for this limited use case.

There are extracted ODR and Mesh files in the test_assets directory for a PED model from GTA5. 

To run the test, start the Docker service on your machine and run `./test_results.sh`. That will run the openformat-to-obj.py script
for each version of Python in docker-compose.yml and verify all files exist and that the MD5SUM matches to Python 3.12 files.

Python 3.2 and 3.3 do not have the Enum module so I suspect this script never worked with those versions of Python.

## Original Readme
Converts OPENIV (GTA5) odr files to wavefront obj files.

Useful for viewing or modifiying GTA5 3D models.

Requirements
--------------
- OpenIV 2.8
- Python3 (https://www.python.org/downloads/)

Usage
--------------
The script requires 1 argument - a glob or filepath to one or many odr files
For each odr it outputs an obj and a mtl file for easy viewing.

By default it checks for a pre-existing obj file, if it finds one that it created previously, it will not run the conversion on that particular odr file.

To overide this behaviour, add the optional argument '-f' or  '--force', and it will re-convert those odr files.

Example
--------------
    python3 openformat-to-obj.py **/*.odr -f

Or
    
    python3 openformat-to-obj.py "C:\GTA5Models\prop_shamal_crash.odr"

![](http://i.imgur.com/DjOCy7O.png)
