#!/bin/bash

if [ "${ES_HOST}" ]; then
  sed -i "s%127\.0\.0\.1%$ES_HOST%g" /config.yml
fi

if [ "$ES_PORT" ]; then
  sed -i "s%port:.*%port: $ES_PORT%g" /config.yml
fi

if [ "$LOG_LEVEL" ]; then
  sed -i "s%loglevel:.*%loglevel: $LOG_LEVEL%g" /config.yml
fi

if [ "$TIMEOUT" ]; then 
  sed -i "s%timeout:.*%timeout: $TIMEOUT%g" /config.yml
fi

if [ "$UNIT" ]; then
  sed -i "s%unit:.*%unit: $UNIT%g" /action.yml
fi

if [ "$UNIT_COUNT" ]; then
  sed -i "s%unit_count:.*%unit_count: $UNIT_COUNT%g" /action.yml
fi

help(){
  echo "Usage: docker <options> elastic-curator <commmand>"
  echo ""
  echo "Commands"
  echo ""
  echo "-a,--action      Displays the action file content"
  echo "-c,--config      Displays the config file content"
  echo "--dry-run        Dry run of config and actions"
  echo "-h,--help        Displays this help menu"
  echo "--help-curator   Displays the help menu from curator (advanced uses)"
  echo "-s,--settings    Displays a list of definable variables and their default values"
  echo "-r,--run         Execute config and actions on an elasticsearch host"
  echo "--version        Displays the version of curator installed"
  echo ""
}

settings(){
  echo ""
  echo "Define these variables using docker -e"
  echo ""
  echo "ES_HOST $(cat /config.yml 2>/dev/null | sed -n -e '/hosts:/,/-/ p' | grep -v hosts: | sed 's%[-]%%' | awk '{print $NF}')"
  echo "ES_PORT $(cat /config.yml | grep port: | awk '{print $NF}')"
  echo "LOG_LEVEL $(cat /config.yml | grep loglevel: | awk '{print $NF}')       # Accepts CRITICAL, ERROR, WARNING, INFO, or DEBUG"
  echo "TIMEOUT $(cat /config.yml | grep timeout: | awk '{print $NF}') seconds"
  echo "UNIT $(cat /action.yml | grep unit: | awk '{print $NF}')        # Accepts seconds, minutes, hours, days, weeks, months, or years"
  echo "UNIT_COUNT $(cat /action.yml | grep unit_count: | awk '{print $NF}')"
}

case $1 in
        --action|-a)
          cat /action.yml
          ;;
        --config|-c)
          cat /config.yml
          ;;
        --help|-h)
          help
          ;;
        --help-curator)
          curator --help
          ;;
        --dry-run)
          curator --config /config.yml --dry-run /action.yml
          ;;
        --run|-r)
          curator --config /config.yml /action.yml
          ;;
        --settings|-s)
          settings
          ;;
        --version)
          curator --version
          ;;
        *)
          curator $@
          ;;
esac
