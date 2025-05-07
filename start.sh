#!/bin/bash

#Inicia Supervisord

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

