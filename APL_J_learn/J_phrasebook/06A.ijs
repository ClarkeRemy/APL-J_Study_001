m0=: /:~        NB. Sort the array in ascending order
m1=: \:~        NB.   "               descending order
m2=: /:~"_1     NB.Sort the items of array y ascending
d3=: /:@:{ {  [ NB. Sort indicies x according to y
d4=: ]/: {"1    NB. Sort table y according to column x
d5=: \:@[`(/:@[)@.] NB. Grade x up if y is 1 and down if y is 0
d6=: \:~@[`(/:~@[) @. ] NB. Sort up or down (Try litteral argument)
d7=: /:~        NB. Sort y according to x

]Y=:'leap','note',:'file'
m1 Y
m1"1 Y

]Z=: >;: 'to be or not to be that is the question'
(];  m0;  m1;  m2) Z

]q=: ?.15#9
(], m0,: m1) q

X=: 2 3 4 5 0 1 9 8 7 6
Y=: 100+10 4 8 6 7 9 5 3 2 1
X ([,  ],:  d3) Y

Y=: ?.5 6$100
d4=: ]/:  {"1
(0&d4;  2&d4;  5&d4)Y

? 9#9
?. 9#9