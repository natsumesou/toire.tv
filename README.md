[![Build Status](https://secure.travis-ci.org/natsumesou/toire.tv.png?branch=master)](http://travis-ci.org/natsumesou/toire.tv)

## DEVELOPMENT

    grunt server

## PRODUCTION

    NODE_ENV=production forever -e log/error.log start bin/twitch.js
    grunt
