m0=: >: @ +: @ i.      NB. Fist odd integers
m0=: 1 + 2 * i.        NB. Fist odd integers
m2=: +/ @ (1 + 2 * i.) NB. Sum of odd integers
m3=: [: +/ 1+ 2*i.     NB. Same as m2 using cap
m4=: m2 -: *:          NB. Sum of odds is square (Tautology)
d5=: < i. 1:           NB. Index of first element where x<y ; also works for = ~: < <: >: > E.
d6=: < i. 0:           NB.    "       "           where not x<y
d7=: < i: 1:           NB.    "     last element where x<y
d8=: < i: 0:           NB.    "     last element where x<y
d9=: [: +/ <           NB. The number of elements where x<y

(<i. TRUE=.1:)  NB. TRUE would be a constant function
(<i. FALSE=.0:)
(<i: TRUE=.1:)
(<i: FALSE=.0:)