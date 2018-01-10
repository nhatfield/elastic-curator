# Elastic-Curator Docker Container
Python-Pip Curator
https://pypi.python.org/pypi/elasticsearch-curator

## INTRO
Use this container to run curator as a docker container. It comes pre-packaged with a default config and action file to delete indices that are older than 7 days. You can configure these settings by passing in the appropriate environment variables.

## BUILD
    docker build -t elastic-curator .

## EXAMPLES

Run, without changing defaults, to hit an elasticsearch host that is local to the elastic-curator container
   
    docker run --rm --net=host elastic-curator -r
    
Likewise you can dry-run to see what the results would be without actually performing the execution
    
    docker run --rm --net=host elastic-curator --dry-run
    
Remote elasticsearch host...

    docker run --rm -e ES_HOST=your-eshost.domain.com elastic-curator -r


## HELP
Pass in the --help or -h flag to get a help menu

    Usage: docker <options> elastic-curator <commmand>

    Commands

    -a,--action      Displays the action file content
    -c,--config      Displays the config file content
    --dry-run        Dry run of config and actions
    -h,--help        Displays this help menu
    --help-curator   Displays the help menu from curator (advanced uses)
    -s,--settings    Displays a list of definable variables and their default values
    -r,--run         Execute config and actions on an elasticsearch host
    --version        Displays the version of curator installed

## VARS
Define these variables using docker -e

    ES_HOST 127.0.0.1
    ES_PORT 9200
    LOG_LEVEL INFO       # Accepts CRITICAL, ERROR, WARNING, INFO, or DEBUG
    TIMEOUT 30 seconds
    UNIT days        # Accepts seconds, minutes, hours, days, weeks, months, or years
    UNIT_COUNT 7

