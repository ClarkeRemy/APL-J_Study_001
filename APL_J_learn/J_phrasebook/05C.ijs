m3=: 1 j.  #;._1
u=: 1 0 0 0 1 1 0 1
m3 u

d4 =: m3@[ #  ]
u d4 'abcd'

u d4 i.4 5

]cm=: 3 3$'ABCDEFGHI'
d5=: 1&(|:\.)"2^:2   NB. Minors [5, s.v. 'Outfix'] (eg <"2 d5 i.3 3)
<"2 d5 cm

m42=: <"1@|: NB. Box each column of a matrix

m42 cm

(>@m42 ;  |:) cm

d11=: ir=: i.@#@]                      NB. Indicies of items right argument
d12=: (]*  +./@((,@[+"0 1  ir)=/  ir)) NB. Band matrix(1 0 _1 d12 i.5 5)
(];  0&d12;  _1 0 1&d12)   m=:  i.4 4


d0=: $,         NB. Reshape in APL
d1=: $,:        NB. x copies of y
d2=: -@[ [\  ]  NB. x-column matrix of the items of y
m3=: 1 j. #;_1  NB. Real 1; Imaginary # of 0's between 1's
d4=: m3@[ #  ]  NB. Expand
d5=: 1&(|:\.)"2^2     NB. Minors [5, s.v. 'Outfix'] (e.g. <"2 d5 i.3 3)
d6=: <&.>@{@(i.&.>"_)@$ { ] NB. Minors [4,sect. 3.3]
m7=: (<0 1)&|:        NB. diagonal of table
m7=: (<@i.@#@$ |:  ]) NB. Rank equivalent version
m8=: i.@# {"_1  ]     NB. Diagonal
m9=: =@i.@# #&,  ]    NB. Diagonal (tables only)
m10=: <"1@(,"0~)@i.@# {  ]  NB. Diagonal
d11=: ir=: i.@#@]     NB. Indicies of items of right argument
d12=: (]*  +./@((,@[ +"0 1  ir)=/  ir)) NB. Band matrix
m13=: m14@#               NB. Identity matrix of order of # of items of y
m14=: id=: =@i.           NB. Identity matrix of order y
m15=: =/~@i.              NB.   "
m16=: ,~ $  {.&1@>:       NB.   "
m17=: -@>:@i. {."0  1:    NB.   "
m18=: -@i. |."0 1  {.&1   NB.   "
m19=: ,&1@($&0)"0@i.      NB.   "
m20=: 0&,^:(i.`1:)        NB.   " (but not for y=0)
m21=: #:@(2&^)@i.@-       NB.   "
NB. m22=: [ D. 1@i.       NB. deprecated
m23=: slt=: >/~@i.        NB. Strict lower triangle
m24=: lt=:  >:/~@i.       NB. Lower triangle
m25=: [\@($&1)            NB.   "
m26=: +./\@=@i.           NB.   "
m27=: >:@i. $"0  1:       NB.   "
m28=: >:@i. {."0 1  $&1   NB.   "
m29=: i.@- }."0 1  $&1    NB.   "
m30=: 1&,^:(i.`1:)        NB.   " (but not for y=0)
m31=: i.@- |.!.0"0 1  $&1 NB.   "
m32=: #:@(+/\)@(2&^)@i.@- NB.   "
m33=: ut=: -.@slt         NB. Upper triangle
m34=: +./\"1@=@i.         NB.   " (but not for y=0)
m35=: |.!.0^:(i.`($&1))   NB.   " (but not for y=0)
m36=: -@i. |.!0"0 1  $&1  NB.   "
m37=: #:@(+/\.)@(2&^)@i.@-NB.   "
m38=: [:%.  ,~ $  {.&1 _1@>: NB.   " (! interesting !)
m39=: ]\ %@(i.&.<:@+:)@x: NB. Hilbert matrix but not for y=0

a40=: lor=: [^:           NB. 1 lor gives left; 0 lor gives right
m41=: -.@('  '&E.)#  ]    NB. Remove multiple blanks
m42=: <"1@|:              NB. Box each column of a matrix
m43=: i.@{:@$ <@:({"1)"0 _  ]  NB. "
m44=: [:, (i.@2: ,:  #,  1:) <@,;.3  ]
d45=: <@|:;.1 |:          NB. Box columns
n46=: 1 0 1 0 0 1 d45 i.3 6 NB. Box columns 0 1, 2 3 4, and 5
v47=: {.;  }.             NB. Split first from rest; split y at x
d48=: i.~ ({.; }.@}.)  ]  NB. Split y at first x; eliding first x
m49=: }:;  {:             NB. Split rest from last
c50=: 2 : 'u@{. , v@}.'   NB. f c50 g applies f to first item; g to others
m51=: */~@i.              NB. Multiplication table of order y
m52=: >./~@i.             NB. Maximum table of order y
m53=: ]]\  ([:<:  +:){.  (-{.  1:)  NB. Counterdiagonal matrix of order y (! very clever !)
m54=: [:*./@,  lt@# >:  lnz NB. Is y lower triangular?
m55=: [:-.  0:e.  [:,  ]  NB. Is y zero-free?
m56=: lnz=: ]~:  0:       NB. Locate nonzeros in y
m57=: [:*./@,  ut@# >:  lnz NB. Is y upper triangular?
m58=: ~:/~@i.             NB. Nondiagonal matrix of order y
d59=: ;@([+&.>  <@i."0@]) NB. i{x + i. i{y
m60=: -/\@i.              NB. Alternating series length y
m61=: +/\@i.              NB. First y triangular numbers
