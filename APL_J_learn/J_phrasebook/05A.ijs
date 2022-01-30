m0=: ,:    NB. Add leading dimension of length 1
m1=: ,:"_1 NB. Addleading dim of length 1 to items
m2=: ,:"1  NB. Add leading dim of length 1 to rows
m3=: ,:"0  NB. Add leading dimension of legth 1 to scalars
m4=: ,.    NB. 1-column table from list
d5=: ([:":  [:,.  [),"1  (' '"_,"1  [:":  ]) NB.Append row stub x to table y
m6=: ,:-   NB. Array and it's negative
m7=: #:&.<:@# $  ]