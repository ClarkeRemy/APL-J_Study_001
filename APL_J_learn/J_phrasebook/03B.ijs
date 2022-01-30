X=: >;: 'That they hunted from hill'
Y=: >;: 'second time me to plain'
b=: 0 1 1 0 0 1 0 0 1 1
mrg=: adverb : '/:@:/:@(m"_) { ,' NB. makes a fork
X([ ; ] ; (,.b)"_ ; b mrg)Y

b mrg NB. sorted permutation of boolean vector

MRG=: /:@:/:@[ { ]
b MRG X,Y

b=: 0 2 2 1 0 2 2 2 0 0 1 1 2 1 2 1 1 1 1 1
y0=: 'abcd' [ y1=: '123456789' [ y2=: 'zzzzzzz'
b MRG y0,y1,y2

a0=: mrg 1 : '/:@/:@(m"_) { ,' NB. X b mrg merges X and Y
m1=: MRG=: /:@/:@[ { ]         NB. b MRG x,y is equivalent to above
d2=: alt=: ,@,.                NB. Merge from X and Y alternatetly

X=: 'temr rtes'
Y=: 'h axbohr '
X alt Y

X=: 'ABCD' [ Y=: 'abcdefghij'
i=: 4 2 8 6
i{Y

]z=: X i} Y

M=: a.{~(a. i. 'A')+i.5 5
]i=: 2 #&.> i. # M

X=: '+-*%^'
M ; (i{M) ; X ; X i} M

IR=: @(i.@$@]) NB. Adverb to select indecies of (ravelled) table right argument
A=: IR }       NB. Adverb to amend selected portion of right argument
d=: (<0 1)&|:  NB. Function to select diagonal of a table
'+-*%^' (] ; d@] ; ]IR ; d IR ; d IR } ; d A) M

ur=: 2 _3&{. NB. Select upper right corner
(2 3$'+-*%^!') (] ; ur@] ; ]IR ; ur IR ; ur IR } ; ur A) M

a3=: IR=: @(i.@$@]) NB. f IR selects indecies of ravelled rgt arg
m4=: d=: (<0 1)&|:  NB. Function to select ravelled rgt arg 
m5=: ur=: 2 _3&{.   NB. Function to select upper right corner



NB. My experiments

APLidx=:  $ <@#:"_ 0 ] NB. index like APL
(<0 2) |: APLidx ($ i.@:(*/)) 2 2 2 NB. where axis 0 and 2 are the same
rep=: (< _3 _2  _1 ) |: APLidx ($ i.@:(*/)) shp =: 3 $ 3 NB. use negative axis index if easier
('_' rep } shp $ '#') ; <rep NB. show relation

