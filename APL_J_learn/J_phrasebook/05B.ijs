X=: 1 1 0 0 0 1 0 0 1 1
Y=: 3 4 8 2 5 6 9 4 5 4
X +/ ;. 1 Y
X < ;. 1 Y

X +/ ;. 2 Y
X < ;. 2 Y

X+/\;.2 Y

; X <@(+/\);.2 Y

cut=: conjunction : ';@(<@u;.n)'
X +/\cut 1 Y
X +/\cut 2 Y

c0=: cut=: conjunction :';@(<@u;.n)'
a1=: c1=: cut 1         NB. Case 1 of cut
a2=: c2=: cut 2         NB. Case 2 of cut
d3=: pmax=:  >./c1      NB. Partitioned max over (case 1)
d4=: pmax2=: >./c2      NB. Partitioned max over (case 2)
d5=: pmaxs=: >./\c1     NB. Partitioned max scan
d6=: pnub=:  ~.c1       NB. Partitioned nub
d7=: psort=: /:~c1      NB. Partitioned sort
d8=: prev=:  |.c1       NB. Partitioned reverse
m9=: <;._2@(,&':');._2  NB. UNIX /etc/passwd relation

X
Y
X(pmax,:  pmax2)Y
X([, ], psort,: prev)Y

p=: >;: 'sparkle out among the fern to bicker down a valley'
X(,.@[ ;  ,.@] ;  psort ;  prev)p

q=: 0 4 2 3 0 4 7 6 0 2
<c1 q

psort q
r=: >;:'/do you love me / or do you not / you told me once / but I forgot'
< cut 1 r
<cut _1 r