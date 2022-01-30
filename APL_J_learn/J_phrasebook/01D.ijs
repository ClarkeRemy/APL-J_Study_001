d0=: +/  NB. Addition table
d1=: */  NB. Multiplication table
d2=: >./ NB. Maximum table
d3=: [ by ] over +/      NB. Bordered addition table
d4=: by=: ' '&;@,.@[,.]  NB. Format function
d5=: over=: ({.;}.)@, NB. Format function
m6=: +/~@i. NB. Addition table on first y integers
m7=: bc=: !/~@i. NB. Binomial coefficients of order y
a8=: ft=: 1 : 'x/~@i.' NB. Function table
a9=: bft=: 1 : 'i. by i. over u/~@i.' NB. Bordered function table (Explicit definition)

2 3 5 (d0 ; d1 ; d2) 0 1 2 3 4 5

2 3 5 d3 0 1 2 3 4 5

(m6 ; m7) 5

% a9 5