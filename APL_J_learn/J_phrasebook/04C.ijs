d0=: -:&(/:~)    NB. Are x and y permutations of each other
m1=: /:~-: i.@#  NB. Is y a permutation vector
m2=: -:-@|:      NB. is y antisymetric?
m3=: -:|:        NB. is y symmetric?
m4=: [:+./ [:*./ ]=/ (0 1)"_ NB. Are all atoms of Boolean list y equal?
m5=: *./ .= +./  NB. Are all atoms of Boolean list y equal?
m6=: *./ .= *./  NB. Are all atoms of Boolean list y equal?
d7=: -.@(] <:/ .>: >.@], [)"1 NB. is y in the half open on the right interval x and is it an einteger?
d8=: e.          NB. Is list x a row of array y?
m9=: *./@(= >./\)    NB. are columns of y in ascending order?
m10=: *./(@= <./\)   NB. are columns of y in decending order?
m11=: >./= <./   NB. Are atoms of numerical list y equal?
m12=: *./+. -.@(+./) NB. Are atoms of Boolean list y equal?
m13=: *./= +./   NB. Are atoms of Boolean list y equal
m14=: *./@(={.)  NB. Are atoms of list y equal
m15=: 0= #| +/   NB. Are atoms of Boolean list y equal?
m16=: *./@(#1&|.)NB. Are atoms of Boolean list y equal

m17=: ([:,: 0,#) -: v19"_ rxmatch ] NB. Is this y legal J name?
d18=: rxmatch=: 17!:0 NB. " to get rxmatch
v19=: '[[:alpha:]][[:alnum]_]* '"_
