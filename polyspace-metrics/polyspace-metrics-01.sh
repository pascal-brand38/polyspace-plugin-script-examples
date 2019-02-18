# Copyright (c) 2019 The MathWorks, Inc.
# All Rights Reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

#
# Example of polyspace metrics usage in ***JenkinsPlugin***
# Please refer to ***https://github.com/mathworks/plugin*** in order to configure the
# jenkins plugin
#
# Different steps are used
# 1- Sniff the project
# 2- Run Bug Finder or Code Prover
# 3- Upload results on Polyspace Metrics
# 4- Generate Report
# 5- Filter Report
# 6- Send email with the report
#

set -e
export RESULT=ResultBF
export PROG=Bug_Finder_Example
export REPORT=$RESULT/Polyspace-Doc/Results_List.txt
rm -rf Notification && mkdir -p Notification



#
# 1- Sniff the project
#    Pre-requite: the sources must be checkout in the workspace
#                 this can be performed using the jenkins git plugin: https://github.com/jenkinsci/git-plugin
#
build_cmd="gcc -c sources/*.c"
polyspace-configure \
      -allow-overwrite \
      -allow-build-error \
      -prog $PROG \
      -author jenkins \
      -output-options-file $PROG.psopts \
      $build_cmd

#
# 2- Run Bug Finder
#
polyspace-bug-finder-server -options-file $PROG.psopts -results-dir $RESULT

#
# 3- Upload results on Polyspace Metrics
#
$ps_helper_metrics_upload $RESULT

#
# 4- Generate Reports in $RESULT/Polyspace-Doc/Results_List.txt
#
polyspace-report-generator -generate-results-list-file -results-dir $RESULT

#
# 5- Filter Reports
# In this example, we are interested in all Red Defects
#
$ps_helper report_filter                          \
    $REPORT                                       \
    Notification/Results_All.tsv                  \
    Family "Defect"                               \
    Color "Red"

#
# 6- Send email with the report
#
#
# Performed by the post-build action, when Polyspace Notification post-build action
# is parametrized as:
#
#   Send to recipients [Checked]
#     Recipients: Users to receive the notification, separated by commas
#     File to attach: Notification/Results_All.tsv
#     Mail Subject: <empty>
#     Mail Body: <empty>
#
#   Send to Owners [Unchecked]
#

#
# Finalize Jenkins status
#
exit 0

