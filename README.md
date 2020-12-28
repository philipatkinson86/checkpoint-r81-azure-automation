# Automation & Orchestration with Check Point IaaS (R81) / Azure
This project demonstrate some automation capabilities of Check Point (R81) & Azure using various 3rd party tools.

## Overview
This is an enhancement to a github project completed earlier this year - for an overview of the previous project along with a more detailed analysis of the code, processes and pre-requisites to build this environment, take a look at my article on "Check Mates", our Check Point community hub as well as the previous github repo here:

https://community.checkpoint.com/t5/API-CLI-Discussion-and-Samples/Automation-amp-Orchestration-with-Check-Point-IaaS-Azure/m-p/95914#M5147

https://github.com/philipatkinson86/azure-checkpoint-automation

## Enhancements / Changes
Here are a list of the enhancements and changes made in this project:
* Updated the scripts to use Check Point R81 images / API
* Automated manual task of changing Mgmt IP by using R81 new API feature in ansible playbook
* Automated manual task of enabling / configuring CME by using an ansible RAW plugin
* Added a reboot of the Mgmt server after ansible playbook to finalize enablement of CME
* Changed the SIC password for GWs in Terraform
* Removed deprecated Terraform code to avoid a warning message on tf apply
* Updated secureme.sh shell script to cater for the above changes including additional sed command to replace IP after 1st tf apply

## Further Notes
* Ensure to add all required Azure IDs in ansible/cme-config.yml where marked as REDACTED
* Ensure to use R81 version of SmartConsole when accessing Mgmt server manaully - can be downloaded from https://supportcenter.checkpoint.com/supportcenter/portal?action=portlets.DCFileAction&eventSubmit_doGetdcdetails=&fileid=111186
* Condition observed sometimes where 1 of the Azure GW instances is corrupt and unable to have a policy pushed to it, the workaround for this is to delete the image and allow the scale set to re-deploy a new one - I have added some code at the bottom of the secureme.sh to automate this if required via the Azure CLI - this is commented out currently as the affected instance ID appears to be random
