d0=: QI=: ?.@$ NB. Shape x of integers from i. y
d1=: QD=: ?.@(,:~)@$ NB. Shape 2,x of integers from i.y
d2=: QN=: -/@QD  NB. Random negative and positive integers
d3=: QF=: %/@QD  NB. Random fractions
d4=: QC=: j./@QD NB. Random complex numbers
d5=: QA=: {&a.@(a.&i.@]+  [QI 26"_) NB. Random literal (26 beginning at y)
m6=: QI&10 NB. Array of random single-digit integers
m7=: QZ=: QI&1 NB. Array of zeros
m8=: QB=: QI&2 Array of Booleans


(QA&'A' ; QA&'a' ; QA&'+') 2 3 4

NB. apply to box
a9=: B=: {{ <"x]y}} NB. Adverb: k B is box of rank k NB. made it a verb
m10=: B0=: 0 B ]    NB. Box atoms
m11=: B1=: 1 B ]    NB. Box vectors (lists)
m11=: B2=: 2 B ]    NB. Box matricies (tables)
m13=: RG=: (1 + >./ - <./)@, NB. Range of values of y
d14=: SC=: * % RG@] NB. scale range of y to scalar x
m15=: NR=: 1&SC     NB. Normalize range to 1
m16=: SZ=: - <./@,  NB. Shift to make smallest value zero
m17=: NM=: SZ@NR    NB. Normalize to range 1 and min value 0

B0 B1 2 3 4 QA 'A'

B2 3 4 5 QA 'a'

(] ; NR ; SZ ; NM) 3 4 QN 10