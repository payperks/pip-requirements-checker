#!/bin/bash -e

#
# Get a copy of the codebase, create a virtualenv based on it and see if
# any of the libraries are ready to be upgraded.
#
# To work this needs to have a SSH id rsa trusted by github for deployment.
#



function print_help {

  echo
  echo "$0 [-b branch] <git uri>"
  echo 
  echo "Compare lib versions from a requirements.txt in a Python project in"
  echo "GitHub to latest available versions in PyPy"
  echo
  echo "Options:"
  echo
  echo "   -b <branch>   - use alternate branch; default is master"
  echo "   -h            - this help"
  echo
  echo "Example: $0 -b master git@github.com:payperks/py-alex-req-project.git"
  echo

}

# =====================================================================
#  Read CLI options

BRANCH=master

set -- $(getopt hb: "$@")
while [ $# -gt 0 ]
do
    case "$1" in
    (-b) BRANCH=$2; shift; shift;;
    (-h) print_help; exit 0;;
    (--) shift; break;;
    (-*) print_help; exit 0;;
    (*)  break;;
    esac
    shift
done



if [ "$1" == '' ]
then
  print_help
  exit 1
fi

GITSOURCE="$1"



# =====================================================================
#  Check dependencies

for pkg in "git python virtualenv"
do
  if [ "`which $pkg`" = '' ]; then
    echo "Can't find your $pkg binary; giving up"
    exit 1
  fi
done




# =====================================================================
#  Fetch ourselves a copy of the code

CODEDIR=`mktemp -d "$TMPDIR/CheckPipUpdates_code.XXXXXX"`
git clone --quiet -b "$BRANCH" "$GITSOURCE" "$CODEDIR"

if [ ! -f "$CODEDIR/requirements.txt" ]
then
  echo "Error; this source tree lacks a requirements.txt"
  rm -rf "$CODEDIR"
  exit 1
fi



# =====================================================================
#  Build a virtualenv based on it

VENVDIR=`mktemp -d "$TMPDIR/CheckPipUpdates_venv.XXXXXX"`
virtualenv --quiet "$VENVDIR"
. "$VENVDIR/bin/activate"
pip install --quiet -r "$CODEDIR/requirements.txt"


# =====================================================================
#  Run a short script to check every module against the latest version


python <<__END_OF_MY_CODE__

import xmlrpclib
import pip

pypi = xmlrpclib.ServerProxy('http://pypi.python.org/pypi')
for dist in pip.get_installed_distributions():
    available = pypi.package_releases(dist.project_name)
    if not available:
        # Try to capitalize pkg name
        available = pypi.package_releases(dist.project_name.capitalize())
        
    if not available:
        msg = 'no releases at pypi'
    elif available[0] != dist.version:
        msg = '{} available'.format(available[0])
    else:
        msg = 'up to date'
    pkg_info = '{dist.project_name} {dist.version}'.format(dist=dist)
    print '{pkg_info:40} {msg}'.format(pkg_info=pkg_info, msg=msg)

__END_OF_MY_CODE__



rm -rf "$CODEDIR" "$VENVDIR"

