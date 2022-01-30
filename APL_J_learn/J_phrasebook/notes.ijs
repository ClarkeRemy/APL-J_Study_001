lala=: t@g [ (t=: +: ) [ g=: +/%  #

,.<@names"0(0 1 2 3 6) NB. noun, adverb, conjunction, verb, locale

ultimate
penultimate
antepenultimate

advshowloc_z_ =: 1 : 0
smoutput 'Executed in ',>coname''
u
)

+ advshowloc

v_new_ =: +
v =: -
t =: v advshowloc_new_
t 6

advshowloc_z_ =: 1 : 0
smoutput 'Executed in ',>coname''
u y
)

v advshowloc_new_ 6
t=: v advshowloc_new_
t 6

t_new_ =: v advshowloc_new_
t_new_ 6


make=: verb define 
NB. make doubly-linked queue of (y) numbered locales
for_i. i.y do.
 conew 'loc'
 NB. i conew 'loc' NB maybe like this?
 NB. loc=. < ": i NB. this line didn't work
 name__loc=: 'This is locale ',":i
 prev__loc=: <": y| i-1
 next__loc=: <": y| i+1
end.
empty ''
)


inspect=: verb define
NB. inspect contents of numbered locale (y)
cocurrent ": y
p=. smoutput f.
p '----------'
p names '' [ p 'contents of locale: ' , ": y
p name [ p 'name:'
p prev [ p 'prev:'
p next [ p 'next:'
)

inspect2=: verb define
NB. inspect contents of numbered locale (y)
NB. Use object locatives instead of: cocurrent''
loc=. <": y
p=. smoutput f.
p '----------'
p names__loc '' [ p 'contents of locale: ',": y
p name__loc [ p 'name:'
p prev__loc [ p 'prev:'
p next__loc [ p 'next:'
)

make 5


head=: <,'3'
name__head NB. object locative: the value of name in locale 3
next__head
name__next__head
name__next__next__head
name__next__next__next__head
name__prev__head
name__prev__prev__head

coclass 'MyFourthApp'
sum =: +/
sum_z_=:sum_MyFourthApp_
cocurrent 'base'


