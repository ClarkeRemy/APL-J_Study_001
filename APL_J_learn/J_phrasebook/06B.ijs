m0=: i.~ /:~  NB. Rank y rising, 0-origin, ties equal
m1=: >:@m0    NB.    "         , 1-origin, ties equal
m2=: i.~ \:~  NB. Rank y falling, 0-origin, ties equal
m3=: >:@m2    NB.    "          , 1-origin, ties equal
m4=: /:@/:    NB. Rank y rising, 0-origin, distinct ranks
m5=: /:@\:    NB. Rank y falling, 0-origin, distinct ranks
m6=: - <./    NB. Normalize y so that minimum atom is 0
d7=: ]*  [%  [:>./  ]       NB. Scale y by x%max y
d8=: <:@[ <.  [ <.@d7  m6@] NB. Classify y into x equal intervals
d9=: [:+/"1  ([:i.  [:{.])=/  ([:<.  ([-  1{])%  ([:{:])) NB. Classify x into {.y classes, minimum 1{y, width {:y
d9=: [:+/"1  i.@{.@] =/  ([-  1{])<.@:%  {:@] NB. Classify x into {.y classes, minimum 1{y, width {:y
d10=: contour=: d12 d11  ]  NB. Classify altitudes x into contour levels y
d11=: ([:<:  [:+/  <:/~) { ]
d12=: [>.  <./@]


]Z=:(],  m0,  m1,  m3,  m4,  m5,:  m6) Y=: 4 2 1 1 2 0 2 5 5 0

0j2":  10 d7"1 Z  NB. Scale

X=: 3 _3 10 22 8
Y=: _5 0 5 10 20 30

X ([, d12,  d11,:  contour) Y



]test=: ?.20#50
]test2=: ?.10#50
m0 test
(,.@:] ;  ,.@:/: ;  ,.@:/:@/: ;  ,.@:/:@/:@/:) test2
/:/: test