log=: verb : '10 ^. y' NB. verb =: 3
log=: 13 : '10 ^. y'

a0=: def=: : 0 NB. Adverb for entering explicit definitions

LOG=: verb : 0
10 ^. y
:
x ^. y
)

rat=: conjunction : 0 NB. conjunction
m&p. % n&p.
)

mat=: [;._2 (0 : 0)   NB. Define matrix
one
two
three
)

boxed=: <;._2 (0 : 0) NB. Define boxed list
one
two
three
)

fn=: verb : 0"1       NB. Assign rank to an explicitly defined function
< +/ y
< +/ y
)

t=: 3
3 : 0 t              NB. Execute unnamed explicit definition
if. 2|y do. 'odd' else. 'even' end.
)

mat
$mat
boxed
fn i. 3 4