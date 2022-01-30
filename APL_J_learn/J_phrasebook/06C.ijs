m0=: /:    NB. Grade y up
m1=: \:    NB. Grade y down
d2=: /:@i. NB. Grade y up according to key x
d3=: \:@i. NB. Grade y down according to key x

Y=:'leap',  'note',:  'file'
(];  m0;  (m0{  ]);  m1;  (m1{  ])) Y

]X=: ' ',u: (a.i.'a') + i. 26 [ Y=: 'senator'
X (d2;  (d2{]);  d3;  (d3{])) Y