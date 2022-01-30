v0=: 10&^. : ^.   NB. Base 10 log for monadic case
v1=: 10&$: : ^.   NB. Same using self-reference to dyad
v2=: 10&^. : ($:@] * ^.@(10"0) % ^.@[) NB. Same using self-reference to monad
d3=: res=: [: : | NB. domain of manad is empty (dyadic only)
m4=: abs=: | : [: NB. domain of dyad is empty (monadic only)