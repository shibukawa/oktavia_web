buildall: gettranslation build

gettranslation:
	mv locale/ja locale/ja_JP || true
	tx pull -l ja_JP
	mv locale/ja_JP locale/ja
	txutil --locale-dirs=locale build-mo

build:
	tinker -b --language ja
	../oktavia/bin/oktavia-mkindex -i blog/html -r blog/html -m html -c 5 -u file
	mv blog/html _tmp_ja
	tinker -b
	../oktavia/bin/oktavia-mkindex -i blog/html -r blog/html -m html -c 5 -u file
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
