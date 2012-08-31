
set border 2 front linetype -1 linewidth 1.000
set boxwidth 0.5 absolute
set style fill   solid 0.25 border lt -1
unset key
set pointsize 0.5
set style data boxplot
set xtics border in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
set xtics  norangelimit
set xtics   ("A" 0.00000, "B" 2.00000)
set ytics border in scale 1,0.5 nomirror norotate  offset character 0, 0, 0 autojustify
#set yrange [ 0.00000 : 100.000 ] noreverse nowriteback

plot 'dependency.dat' using 2:3
pause -1
#
#min_y = GPVAL_DATA_Y_MIN
#max_y = GPVAL_DATA_Y_MAX
#
#f(x) = mean_y
#fit f(x) 'accessed.dat' using 2:3 via mean_y
#
#stddev_y = sqrt(FIT_WSSR / (FIT_NDF + 1 ))
#print stddev_y
#
#plot min_y with filledcurves y1=mean_y lt 1 lc rgb "#bbbbdd", \
#     max_y with filledcurves y1=mean_y lt 1 lc rgb "#bbddbb", \
#     mean_y+stddev_y with filledcurves y1=mean_y lt 1 lc rgb "#ff00ff", \
#	 mean_y w l lt 3, 'stats2.dat' u (1):2 w p pt 7 lt 1 ps 1, \
#     'accessed.dat' u 2:3 w p pt 7 lt 1 ps 1
#
#
#pause -1
