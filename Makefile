# Twilio API helper library.
# See LICENSE file for copyright and license details.

define LICENSE
<?php

/**
 * Twilio API helper library.
 *
 * @category  Services
 * @package   Services_Twilio
 * @author    Neuman Vong <neuman@twilio.com>
 * @license   http://creativecommons.org/licenses/MIT/ MIT
 * @link      http://pear.php.net/package/Services_Twilio
 */
endef
export LICENSE

all: test

clean:
	@rm -rf dist

PHP_FILES = `find dist -name \*.php`
dist: clean
	@mkdir dist
	@git archive master | (cd dist; tar xf -)
	@for php in $(PHP_FILES); do\
	  echo "$$LICENSE" > $$php.new; \
	  tail -n+2 $$php >> $$php.new; \
	  mv $$php.new $$php; \
	done

test-install:
	! pear channel-discover pear.phpunit.de
	! pear channel-discover components.ez.no
	! pear channel-discover pear.symfony-project.com
	! pear channel-discover pear.survivethedeepend.com
	! pear channel-discover hamcrest.googlecode.com/svn/pear
	! pear install --alldeps deepend/Mockery
	! pear install phpunit/PHPUnit

# if these fail, you may need to install the helper libraries - see "Running
# Tests" at http://readthedocs.org/projects/twilio-php/.
test:
	phpunit --strict --colors --configuration tests/phpunit.xml

.PHONY: all clean dist test
