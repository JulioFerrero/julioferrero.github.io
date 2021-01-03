#!/bin/bash

TITLE='/ᐠ.ꞈ.ᐟ\\ Cursed Cat'
SUBTITLE="Digital community by \\& for cats"

rm -rf *.html
rm -rf posts/*.html

sed -i -e "s,\<TITLE_GOES_WHERE\>,$TITLE,g" ./static/_header.html
sed -i -e "s,\<SUBTITLE_GOES_WHERE\>,$SUBTITLE,g" ./static/_header.html

touch posts/index.html
cat static/_header.html >> posts/index.html

for p in $(ls *.md && ls -t posts/*.md);
do
	echo "Creando archivo html de: "$p;
	NEWHTML=$(echo $p | cut -d '.' -f 1).html &&
	touch $NEWHTML &&
	cat static/_header.html >> $NEWHTML &&
	markdown $p >> $NEWHTML &&
	cat static/_footer.html >> $NEWHTML

	if [[ $p  == posts/* ]]
	then
		ONLYNAMEHTML=$(echo $NEWHTML | cut -d '/' -f 2)
		ONLYNAME=$(echo $ONLYNAMEHTML | cut -d '.' -f 1 | tr "_" " ")
		echo "<a href=\"$ONLYNAMEHTML\">$ONLYNAME</a>" >> posts/index.html
		echo "<br>" >> posts/index.html
	fi
done

cat static/_footer.html >> posts/index.html

sed -i -e "s,\<$TITLE\>,TITLE_GOES_WHERE,g" ./static/_header.html
sed -i -e "s,\<$SUBTITLE\>,SUBTITLE_GOES_WHERE,g" ./static/_header.html
