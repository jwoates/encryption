BRANCH=$(shell git status|grep "On branch" | cut -f4 -d" ")
PROD=dev@50.57.170.253:/var/www/rush-production.rh-apps.com/public_html/
STAGE=dev@50.57.170.253:/var/www/rush-stage.rh-apps.com/public_html/

default: 
	@echo $(master)

pull:
	rsync --exclude-from=rsync.exclude -rcv $(STAGE) ./

fakepull:
	rsync --exclude-from=rsync.exclude -rcvn $(STAGE) ./

pushdel:
	rsync --exclude-from=rsync.exclude -rcv --delete ./ $(STAGE)


pushstage:
	rsync --exclude-from=rsync.exclude -rcv ./ $(STAGE)

pushprod:
ifeq ($(BRANCH),production)
	rsync --exclude-from=rsync.exclude -rcv ./ $(PROD)
else
	 @echo "Push to PRODUCTION must be done from PRODUCTION branch"
endif


restartstage:
	ssh dev@50.57.170.253 'touch /var/www/rush-stage.rh-apps.com/public_html/tmp/restart.txt'

restartprod:
	ssh dev@50.57.170.253 'touch /var/www/rush-stage.rh-apps.com/public_html/tmp/restart.txt'

fakepush:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ $(STAGE)