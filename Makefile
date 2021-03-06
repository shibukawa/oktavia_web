buildall: gettranslation build

gettranslation:
	mv locale/ja locale/ja_JP || true
	tx pull -l ja_JP
	mv locale/ja_JP locale/ja
	txutil --locale-dirs=locale build-mo

build:
	cp ./node_modules/.bin/web/oktavia-jquery-ui.js ./_static/
	tinker -b --language ja
	./node_modules/.bin/oktavia-mkindex-cli -i blog/html -r blog/html -m html -c 5 -u file -t web -o blog/html/searchindex.js
	mv blog/html _tmp_ja
	tinker -b
	./node_modules/.bin/oktavia-mkindex-cli -i blog/html -r blog/html -m html -c 5 -u file -t web -o blog/html/searchindex.js
	mv _tmp_ja blog/html/ja
	make -f compress.mk
	./upload.sh

update:
	tinker -u
	rm locale/pot/sphinx.pot
	txutil update-txconfig-resources --locale-dirs=locale --project-name=oktavia
	tx push -s

workon:
	workon tinker

reinstall:
	cd ../oktavia;npm pack;cd ../oktavia_web;npm install ../oktavia/oktavia-1.0.0.tgz
