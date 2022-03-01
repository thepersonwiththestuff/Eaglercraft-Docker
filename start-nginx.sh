#!/bin/bash

/usr/sbin/nginx

/usr/bin/tail -f /var/log/nginx/access.log /var/log/nginx/error.log