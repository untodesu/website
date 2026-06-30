#!/bin/sh
cd $(dirname ${0}) || exit 1
zola build || exit 1
cp -R public/* /var/www/sub-domains/untode.su/ || exit 1
exit 0
