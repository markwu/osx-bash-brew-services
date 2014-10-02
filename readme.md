# Bash Brew Services
A bash script to take some of the pain away from managing homebrew services with launchctl.

### Installation
Copy the script to a directory on your $PATH and make it executable.

```
cp brew-services /usr/local/bin
chmod +x /usr/local/bin/brew-services
```

### Usage
`brew-services install [name] [file]`

Links a plist `[file]` to your personal LaunchAgents directory under the `[name]` you provide. Installed services will start on login unless you disable them manually by editing the plist `[file]`.

`brew-services remove [name]`

Removes the link with the provided `[name]`.

`brew-services start [name]`

Starts an installed service by `[name]`.

`brew-services stop [name]`

Stops an installed service by `[name]`.

`brew-services restart [name]`

Restarts an installed service by `[name]`.

`brew-services list`

Lists all installed services.

`brew-services help`

Displays the script version and usage information.

### Uninstalling
Delete the script.

### Examples
```
$ brew install redis
$ brew-services install redis /usr/local/Cellar/redis/2.8.17/homebrew.mxcl.redis.plist
$ brew-services list
redis
$ brew-services start redis
$ redis-cli
127.0.0.1:6379> exit
$ brew-services stop redis
$ redis-cli
Could not connect to Redis at 127.0.0.1:6379: Connection refused
$ brew-services remove redis
$ brew-services list
$ exit
```
