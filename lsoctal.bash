#! /usr/bin/bash
################
# lsoctal.bash
#
# Syntax  : $ lsoctal.bash
# Purpose : Show file permissions in octal mode
# 
#
#
#
# (c) P.A. van Gemert

ls -l $1 | tail -n +2 | while read line ; do

	uperm=0
	gperm=0
	operm=0
	eperm=0

	[[ $line =~ ^.r........ ]] && (( uperm=uperm+4 ))
	[[ $line =~ ^..w....... ]] && (( uperm=uperm+2 ))
	[[ $line =~ ^...x...... ]] && (( uperm=uperm+1 ))

	[[ $line =~ ^....r..... ]] && (( gperm=gperm+4 ))
	[[ $line =~ ^.....w.... ]] && (( gperm=gperm+2 ))
	[[ $line =~ ^......x... ]] && (( gperm=gperm+1 ))

	[[ $line =~ ^.......r.. ]] && (( operm=operm+4 ))
	[[ $line =~ ^........w. ]] && (( operm=operm+2 ))
	[[ $line =~ ^.........x ]] && (( operm=operm+1 ))

	[[ $line =~ ^...s...... ]] && (( eperm=eperm+4 )) && (( uperm=uperm+1 )) 
	[[ $line =~ ^...S...... ]] && (( eperm=eperm+4 ))

	[[ $line =~ ^......s... ]] && (( eperm=eperm+2 )) && (( gperm=gperm+1 ))
	[[ $line =~ ^......S... ]] && (( eperm=eperm+2 )) &&

	[[ $line =~ ^.........t ]] && (( eperm=eperm+1 )) && (( operm=operm+1 ))
	[[ $line =~ ^.........T ]] && (( eperm=eperm+1 )) && (( operm=operm+1 ))

	echo "$line" | sed 's/^\(.\)........./\1'$eperm$uperm$gperm$operm'/'
done
