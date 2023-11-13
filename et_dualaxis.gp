set datafile separator comma
set xdata time
set timefmt "%Y-%m-%d"
set xtics format "%y %b"

set ytics nomirror 
set y2tics 

set ylabel "Volume (x1,000,000)"
set y2label "High (USD)"
set title "Energy Transfer (E.T.) Daily Stock Analysis"
set key top left reverse Left

set terminal png size 1024,780
set output "dualaxis.png"
plot ["2022-11-03":] "etts.csv" using 1:7 title "Volume" axes x1y1 with lines, \
"etts.csv" using 1:3 axes x1y2 title "High" with lines
