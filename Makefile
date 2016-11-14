# Compatible with GNU make and BSD make.

include config.mk

install:
	@echo Installing to to ${PREFIX}/bin ...
	@mkdir -p ${PREFIX}/bin
	@cp -f weiboshurl.coffee ${PREFIX}/bin/weiboshurl
	@chmod 755 ${PREFIX}/bin/weiboshurl

uninstall:
	@echo Uninstalling from ${PREFIX}/bin ...
	@rm -f ${PREFIX}/bin/weiboshurl
