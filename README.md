pip-requirements-checker
========================
A simple bash+python script to read the requirements.txt in your Python project, generate a temporary virtualenv to match then check the package versions against PyPy to see if any are outdated.

Best called as a weekly cron with the results piped into the mail command & shared with your whole development team.

e.g.

    58 07 * * Tue		pip-requirements-checker | mail -a "From: alex@payperks.com" -s "library check" allthedevs@payperks.com


Usage
-----

```
./pip-requirements-checker [-b branch] <git uri>

Compare lib versions from a requirements.txt in a Python project in
GitHub to latest available versions in PyPy

Options:

   -b <branch>   - use alternate branch; default is master
   -h            - this help

Example: pip-requirements-checker -b master git@github.com:payperks/pip-requirements-checker.git
```

Credits
-------
Python code for interfacing with pip based on https://gist.github.com/3555765

History
-------
* Originally created by Alex Hewson (alex@payperks.com, https://github.com/alexmbird)


License
-------

Copyright (c) 2013, PayPerks, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of PayPerks, Inc. nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

