#!/usr/bin/env gnuplot
set term png size 1280,768	#output terminal and file

set key autotitle columnhead

binwidth=20
bin(x,width)=width*floor(x/width)

set output "filesincluded.png"
plot 'dependency.dat' using ($2) title columnhead(2) with lines
set output "filesincludedhist.png"
plot 'dependency.dat' using (bin($2,binwidth)):(1.0) title columnhead(2) smooth freq with boxes

set output "newfilesincluded.png"
plot 'dependency.dat' using ($3) title columnhead(3) with lines
set output "newfilesincludedhist.png"
plot 'dependency.dat' using (bin($3,binwidth)):(1.0) title columnhead(3) smooth freq with boxes

set output "totalnumberoffilesincluded.png"
plot 'dependency.dat' using ($4) title columnhead(4) with lines
set output "totalnumberoffilesincludedhist.png"
plot 'dependency.dat' using (bin($4,binwidth)):(1.0) title columnhead(4) smooth freq with boxes

set output "numberofaccesses.png"
plot 'accessed.dat' using ($2) title columnhead(2) with lines
set output "numberofaccesseshist.png"
plot 'accessed.dat' using (bin($2,binwidth)):(1.0) title columnhead(2) smooth freq with boxes

#plot 'accessed.dat' using (bin($2,binwidth)):(1.0) smooth freq with boxes
