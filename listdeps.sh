#! /usr/local/bin/bash

# Arguments:
# 1. basepath - /Users

totfiles=0
declare -A oldfiles

dependenciesfile=dependency.dat
accessedfile=accessed.dat
basepathsedscript=",^$1,!d"

echo '"source file" "0" "# files included" "# new files included" "total # files"' > $dependenciesfile
#for file in $(find . -iname "*.d")
for file in $(find . -iname "*.d" -type f -ls | awk '{print $(NF-3), $(NF-2), $(NF-1), $NF}' | sort)
do
	if [ -a $file ]; then
		depfiles="$(cat $file | sed -e ':a' -e 'N' -e '$!ba' -e 's/\s*\\\s*/ /g' | tr ' ' '\012' | sed -e "$basepathsedscript" | sed -e '/h$/!d')"
		newfiles=0
		for depfile in $depfiles
		do
			if [ ! ${oldfiles[$depfile]} ]; then
				let newfiles++
			fi
			oldfiles[$depfile]=$((${oldfiles[$depfile]}+1))
		done
		lines="$(echo $depfiles | tr ' ' '\012' | sed -e "$basepathsedscript" | wc -l)"
		totfiles=$(($newfiles+$totfiles))
		printf "%-50s %5d %5d %5d %5d\n" $file 0 $lines $newfiles $totfiles >> $dependenciesfile
	fi
done

echo '"source file" "0" "# times included"' > $accessedfile
for i in "${!oldfiles[@]}"
do
	printf "%-50s %5d %5d\n" $i 0 ${oldfiles[$i]} >> $accessedfile
done
