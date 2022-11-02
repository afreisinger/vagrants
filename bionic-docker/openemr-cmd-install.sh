#mkdir ~/bin
#! /bin/bash 
curl -L https://raw.githubusercontent.com/openemr/openemr-devops/master/utilities/openemr-cmd/openemr-cmd > /usr/bin/openemr-cmd
curl -L https://raw.githubusercontent.com/openemr/openemr-devops/master/utilities/openemr-cmd/openemr-cmd-h > /usr/bin/openemr-cmd-h
chmod +x /usr/bin/openemr-cmd
chmod +x /usr/bin/openemr-cmd-h