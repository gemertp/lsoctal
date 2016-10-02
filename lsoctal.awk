#! /bin/bash

ls -l | tail -n +2 | awk '

BEGIN {
	uperm = 0
	gperm = 0
 	operm = 0
	eperm = 0
}

$1 ~ /^.r........./ { uperm=uperm+4 }
$1 ~ /^..w......../ { uperm=uperm+2 }
$1 ~ /^...x......./ { uperm=uperm+1 }

$1 ~ /^...S......./ { eperm=eperm+4 }
$1 ~ /^...s......./ { uperm=uperm+1
                      eperm=eperm+4 }

$1 ~ /^....r....../ { gperm=gperm+4 }
$1 ~ /^.....w...../ { gperm=gperm+2 }
$1 ~ /^......x..../ { gperm=gperm+1 }

$1 ~ /^......S..../ { eperm=eperm+2 }
$1 ~ /^......s..../ { gperm=gperm+1 
                      eperm=eperm+2 }

$1 ~ /^.......r.../ { operm=operm+4 }
$1 ~ /^........w../ { operm=operm+2 }
$1 ~ /^.........x./ { operm=operm+1 }

$1 ~ /^.........S./ { erpem=eperm+1 }
$1 ~ /^.........s./ { operm=operm+1
                      eperm=eperm+1 }

{
	ftype = substr($1,0,1)

	printf "%1s%1i%1i%1i%1i%3s %-10s %-10s %10s %3s %2s %6s %s\n", ftype, eperm, uperm, gperm, operm, $2, $3 ,$4, $5, $6, $7, $8, $9, $10

	uperm = 0
	gperm = 0
	operm = 0
	eperm = 0
}

'
