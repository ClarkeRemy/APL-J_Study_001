z=: 0{Y=: 3 3 3$'ABCDEFGHIJKLMNOPQRSTUVWXYZ]'
ibbb=: <ibb=: <ib=: <i=: 1 _1
jbbb=: <jbb=: <jb=: <j=: 2 1
ijbbb=: <ijbb=: <ijb=: <ij=: 2 2$i,j
(] ; i&{ ; ib&{ ; ibb&{ ; ibbb&{) z
(] ; j&{ ; jb&{ ; jbb&{ ; jbbb&{) z
NB. Same Selection

NB. ijb{y NB. Rank Error
ij{z NB. same as ijbb{z
(] ; i&{ ; ijbb&{ ; ijbbb&{) z


'*' ib} z
('def',:'ghi') i}z

(] ; i&{ ; ib&{ ; ibb&{ ; ibbb&{)"2 Y

$(<<''){ z
$(<a:){ z

]k=: <1 2; a:; 0 2 NB. this is key

Y; k{Y
a:{z

n0=: Y=: i. 4 5 6 7 NB. Array used in examples
n1=: (<,<3){Y       NB. Item 3 of Y
n2=: (<,3){Y        NB.    "
n3=: (<3){Y         NB.    "
n4=: 3{Y            NB.    "
*./({. -:/"0 }.)n1;n2;n3;n4 NB.show equivalence

n5=: (<,<_1){Y      NB. Last item of Y
n6=: (<,_1){Y       NB.    "
n7=: (<_1){Y        NB.    "
n8=: _1{Y           NB.    "
n9=: (_1+#Y){Y      NB.    "
showMod=: (#|_1:)Y  NB. This holds for negatives, but for numbers greater than the number of items you will get an index error

n10=: 0{Y           NB. First item of Y
n11=: (-#Y){Y       NB.    "
n12=: 3 0 _2 0{Y    NB. Items 3 0 _2 0 of Y
n13=: i=: ?2 3{$Y   NB. Indecies used in examples
n14=: j=: ? 1{$Y    NB.    "
n15=: k=: ? 7$ 2{$Y NB.    "

n16=: (<i;j;k){Y    NB. Y[i;j;k;] in APL notation
n17=: (<1;2;3){Y    NB. Y[1;2;3;]
n18=: (<1,2,3){Y    NB.    "
n19=: (<1 2 3){Y    NB.    "

n20=: (<<i){Y       NB. Y[i;;;;;]
n21=: (<<,i){Y      NB. Y[,i;;...;]
n22=: (,i){Y        NB.    "

n23=: (<<1 3 2){Y   NB. Items 1 3 2
n24=: (<<<1 3 2){Y  NB. All but items 1 3 2
n25=: (<<<1 3){Y    NB.    "          1 3
n26=: (<<<1){Y      NB.    "          1
n27=: (<<<$0){Y     NB.    "          ... none, i.e all items
n28=: (<<a:){Y      NB. All items

n29=: (<1 3 2;3){Y     NB. Y[1 3 2;3;;...;]
n30=: (<(<1 3 2);3){Y  NB. Y[Y(~⍤∊ (/) (⍳≢)⍤⊣)1 3 2;3;;...;]
n31=: (<(<1 3);3){Y    NB. Y[Y(~⍤∊ (/) (⍳≢)⍤⊣)1 3;3;;...;]
n32=: (<(<1);3){Y      NB. Y[Y(~⍤∊ (/) (⍳≢)⍤⊣)1;3;;...;]
n33=: (<(<$0);3){Y     NB. Y[Y(~⍤∊ (/) (⍳≢)⍤⊣)⍴0;3;;...;]
n33=: (<(<$0);3){Y     NB. Y[;3;;...;]
n35=: (<a:;3){Y        NB. Y[;3;;...;]
n36=: 4{"_1 Y          NB. Y[;4;;...;]
n37=: (<a:; a:; 5){Y   NB. Y[;;5;...;]
n38=: 5{"_2 Y          NB. Y[;;5;...;]
n39=: (<1 2){ Y        NB. Abbreviated (fewer indecies than axes)
n40=: _2{Y             NB. Negative
n41=: (<<<3){Y         NB. Complementary
n42=: (1 2;3 2;0 _2){Y NB.Scattered (non-scalar left argument)


