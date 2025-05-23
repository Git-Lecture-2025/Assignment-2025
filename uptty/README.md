<p align="center">
    <img src="../writeups/images/uptty.png" />

</p>

UpTTY *(uptime + tty)* is a CLI/TUI tool to moniter remote services and get notified when they go down.

![alt text](../writeups/images/demo.png)


# Installation  

Run the following command to install both UpTTY and UpTTY-TUI

```bash
curl -fsSL https://raw.githubusercontent.com/TanmayArya-1p/Assignment-2025/refs/heads/tcan/uptty/install.sh | sudo bash
```

# Configuration

By default the config is stored at `$HOME/.local/share/upt/.uptrc`. To edit the config run

```bash
uptty config
```

The configuration file `uptrc` currently only has 3 options:

### UPT_CSV
Location of the CSV file used for storing Trackers. By default its value is `~/.local/share/uptty/uptime.csv`

### UPT_CRONJOB
`true` or `false` — determines whether the ping cronjob should be enabled.

### UPT_CRONJOB_INTERVAL
An integer value between **1** and **59** (inclusive). This sets the interval in minutes between each execution of the cronjob.

#### An example .uptrc looks like this:
```bash
UPT_CSV="/home/tanmay/.local/share/upt/uptime.csv"
UPT_CRONJOB="true"
UPT_CRONJOB_INTERVAL=1
```


<br></br>
# Commands
