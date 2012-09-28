#! /usr/local/bin/bash

# Arguments:
# 1. base path to analyze, eg /Users
# 2. base name in generated files

totfiles=0
declare -A oldfiles

dependenciesfile="$2_dependency.dat"
accessedfile="$2_accessed.dat"
basename="$(echo $1 | sed -e 's/\//\\\//g')"
basepathsedscript="/^$basename/!d"

echo '"source file" "# files included" "# new files included" "total # files"' > $dependenciesfile
#for file in $(find . -iname "*.d")
for file in $(find . -iname "*.d" -type f -ls | awk '{print $(NF-3), $(NF-2), $(NF-1), $NF}' | sort)
do
	if [ -a $file ]; then
		depfiles="$(cat $file | sed -e ':a' -e 'N' -e '$!ba' -e 's/\s*\\\s*/ /g' | tr ' ' '\012' | sed -e "$basepathsedscript" | sed -E '/(h|hpp)$/!d')"
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
		printf "%-50s %5d %5d %5d\n" $file $lines $newfiles $totfiles >> $dependenciesfile
	fi
done

echo '"source file" "# times included"' > $accessedfile
for i in "${!oldfiles[@]}"
do
	printf "%-50s %5d\n" $i ${oldfiles[$i]} >> $accessedfile
done
