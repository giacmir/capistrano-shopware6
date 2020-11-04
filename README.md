Capistrano tasks for Shopware6
===============================

This gem contains instructions to deploy a [Shopware](https://www.shopware.com) 6 instance with [Capistrano](https://capistranorb.com/).

Details
-------

Deployment process has the following steps:

* `composer install`
* `bin/console maintenance:enable`
* `psh.phar update`
* `bin/console database:migrate_destructive --all`
* `psh.phar administration:build`
* `psh.phar storefront:build`
* `bin/console assets:install`
* `bin/console maintenance:disable`
* `bin/console cache:warmup`

Usage
-----

To use this gem add this to your `Gemfile`

`gem "capistrano_shopware6"`

and then this line to your `Capfile`

`require "capistrano/shopware"`
