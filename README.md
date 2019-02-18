# Polyspace Access Script Examples


This git repository contains a number of script example that can be
used with the Jenkins [Polyspace Plugin](https://github.com/jenkinsci).

2 kinds of examples are provided:

* Examples with connection to Polyspace Access
* Examples with connection to Polyspace Metrics

## Polyspace Access
*polyspace-access* contains script example related to Polyspace Access.
the following scripts are available:

* polyspace-access-01.sh
    * Sniff sources found in sources/*.c using polyspace-configure
    * Run Polyspace Bug Finder
    * Upload results on Polyspace Access
    * Export "High" defects locally
    * Email the exported report to a list of users


## Polyspace Metrics
*polyspace-metrics* contains script example related to Polyspace Metrics.
The following scripts are available:

* polyspace-metrics-01.sh
    * Sniff sources found in sources/*.c using polyspace-configure
    * Run Polyspace Bug Finder
    * Upload results on Polyspace Metrics
    * Generate a report
    * Filter the report to keep Red Defects
    * Email the exported report to a list of users


# TODO
* Fix final version of the Polyspace Plugin (https://github.com/jenkinsci)
* Screen snapshot of Build Environment?
* Link to the Polyspace Plugin Documentation





