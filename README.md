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

Usage
-----
Copyright 2012 PayPerks, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
