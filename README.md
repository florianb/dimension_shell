# Dimension-Shell

A small (and very incomplete) ssh wrapper, to ssh your servers in the Public Cloud of dimensiodata.com easily via their server-name:

```
florianb$ dsh connect my-host
dsh: Server "my-host" found, opening secure shell to 33a0:47c0:110:1211:468:ac2d:62de:191f.
root@2a00:33a0:47c0:110:1211:468:ac2d:62de:191f's password: *
```


## Usage

### Connect to a specific server

```
$ dsh connect SERVERNAME -r REGION -o ORGANIZATION -u USERNAME -p PASSWORD -s SHELL_USER
```

Connects to the DimensionData-API at the specified REGION with the ORGANIZATION-id, USERNAME and PASSWORD to fetch all servers matching to SERVERNAME.

If a matching server is found, its primary ipv6-address is taken to open a ssh-connection with the provided SHELL_USER.

If the SHELL_USER is omitted, the connection will be established as `root`.

### List servers for region

```
$ dsh list -r REGION -o ORGANIZATION -u USERNAME -p PASSWORD
```

Connects to the DimensionData-API at the specified Region with the ORGANIZATION-id, USERNAME and PASSWORD to fetch a list of all servers at the given region.

If the API-call is successful the returned servernames will be printed, followed by their operating system and their current state:

``
super-server (UBUNTU12/64) - NORMAL
1 server/s in total.
``

#### Region

The region-code is expanded to the subdomain `api-REGION`, f.e. the region-code `eu` is expanded to `https://api-eu.dimensiondata.com`.

According to the API-documentation the following region-codes will be accepted by the API:

```
 na: North America
 eu: Europe (EU)
 au: Australia (AU)
 mea: Africa (AF)
 ap: Asia Pacific (AP)
 latam: South America (SA)
 canada: Canada(CA)
```

## Config-File

Dimension-Shell searches in your home-directory for `dsh.yml`, this file may contain your default settings for any command-options. Any options defined in the config file may be omitted in the command-line-invocation.

If any option is defined in the config file and at command-line, the corresponding command-line option overrides the config file.

```
:username: api_server
:region: eu
:organization: 12345678-1234-1234-1234-123456789012
:password: "api_server123"
:shell_user: root
```

> The given user needs only read-permissions to access the api.

## Installation

Install it via Rubygems.org:

```
$ gem install dimension_shell
```

# Help

File an issue - pull-requests are welcome.
