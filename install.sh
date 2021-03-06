#!/bin/bash

echo "$c2            _                                   "
echo "$c2           (_)                                  "
echo "$c2  _ __ ___  _ _ __   ___ _ __   ___  ___  _ __  "
echo "$c2 |  _   _ \| |  _ \ / _ \  _ \ / _ \/ _ \|  _ \ "
echo "$c2 | | | | | | | | | |  __/ |_) |  __/ (_) | | | |"
echo "$c2 |_| |_| |_|_|_| |_|\___|  __/ \___|\___/|_| |_|"
echo "$c2                        | |                     "
echo "$c2                        |_|MobileMinerApp Plugin"
echo "$c2                            by Henry W. (tk1337)"
echo
echo "This will install the MobileMinerApp plugin for MinePeon."
echo "It will require sudo access to install the service and ask"
echo "you for your password."
echo
echo "** You will need to register your email with mobileminerapp.com"
echo "to receive an application key for this service to work. **"
echo
echo "Updates to MobileMinerApp's servers happen every one (1) minute, if"
echo "your system does not instantly show up within your application after"
echo "installing this plugin, please allow it some time."
echo

read -p "Continue installation of MobileMinerApp plugin? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then

  echo
  echo "Enter the email address registered with MobileMinerApp, then press [ENTER]:"
  read email
  echo
  echo "Enter the Application Key received from MobileMinerApp, then press [ENTER]:"
  read appkey
  echo
  echo "[OPTIONAL] Enter what you would like to name this machine (no spaces!), then press [ENTER]:"
  read machinename
  
  mkdir -p /opt/minepeon/http/mma
  cp mobileminerapp.inc.php /opt/minepeon/http/mma/mobileminerapp.inc.php
  cp run.php /opt/minepeon/http/mma/run.php
  
  v=$(sed 's/[^0-9]//g' /opt/minepeon/etc/version)
  if [ "$v" -ge "024" ]
  then
    sudo cp MMAUpdate /opt/minepeon/etc/cron.d/1min/MMAUpdate
    sudo cp MMACmdCheck /opt/minepeon/etc/cron.d/2min/MMACmdCheck
  else
    sudo /usr/bin/php /opt/minepeon/http/mma/run.php installcron
  fi
  
  rm -f mobileminerapp.inc.php
  rm -f MMAUpdate
  rm -f MMACmdCheck

  sudo /usr/bin/php /opt/minepeon/http/mma/run.php installconf $email $appkey $machinename
  rm -f /opt/minepeon/http/mma/run.php
  
  echo
  echo
  echo "If no errors appeared, installation was successful!"
  echo 
fi
