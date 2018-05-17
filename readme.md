# check-new-code

A minimalist git deployment tool with bash script and cron on linux. It works for machine behind firewall and it has minimal dependancies. It will ensure the repo is update-to-date with master branch and it can call a script before and after an update.

Note: tested on Ubuntu 16.04.4 x64

This can be convenient for staging environment. (`flock` prevent concurrent tasks.)

# Installation

1. Update `sudo apt-get update`
2. Generate a new ssh key for this machine: `ssh-keygen -t rsa`
3. (optional) Make sure timezone is configured. ex: `sudo timedatectl set-timezone America/New_York`
4. Add Deploy keys on your GitHub repo:
    - From repo: Settings tab
    - Press on: Deploy keys
    - Press on: Add deploy key
    - Paste in the content of id_rsa.pub (`cat .ssh/id_rsa.pub`)
5. Clone the repo: ``
6. Add scheduled task: `crontab -e`
    - ex: Check every minute. `* * * * * flock /root/myrepo-check-new-code.lock -c "bash /root/check-new-code/check-new-code.sh /root/myrepo /root/myrepo/beforeUpdate.sh /root/myrepo/afterUpdate.sh /root/myrepo-updatelog.txt"`

# Usage

## Parameters:

1. git directory on server
2. before update script (if script missing, skip it)
3. before update script (if script missing, skip it)
4. log file
