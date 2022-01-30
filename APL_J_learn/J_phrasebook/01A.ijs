NB. a adverb 
NB. c conjunction
NB. n noun
NB. m monad
NB. d dyad
NB. v ambivalent verb

n0=: i. 6            NB. List of first six non-negative integers
m1=: ^&3             NB. Cube
m2=: mean=: +/ % #   NB. Arithmetic mean
d3=: $,:             NB. x copies of y (hook)
m4=: <.@(0.5&+)      NB. Round
m5=: =+              NB. Test for real number
m6=: (<0 _1)&C.      NB. Swap leading and final items
m7=: +/\ -: +/\.&.|. NB. Prefix sum scan is suffix under reversal

report=: ? 2 4 3 $ 10
report
mean report
(mean ; mean"2 ; mean"1) report

linearDisplay=: 9!:3 
9!:3 (5)
9!:3 (4)
9!:3 (1 2 4 5)
m7

pss=: +/\
x=: >: i.6
pss x      NB. Subtotals, or partial sums

sss=: +/\.
sss x

sss |. x

|. sss |. x

sss&.|. x

<\x  NB. Box prefix scan
<\.x NB. Box suffix scan

s=: sort=: /:~
numb=: 3 1 4 1 [ char=: 'cage'
poem=: 'i sing','of olaf',:'glad and big'
(,.s numb);(,.s char);poem;(s poem);s"1 poem

NB. 0!:0 <'profile.ijs' NB. not working?
names ''

NB. Parity & Symmetry
n16=: m=: 3 1 4,2 0 5,:1 4 1 NB. A 3-by-3 matrix
d17=: ip=: +/ . * NB. Inner (matrix) product
m18=: L=: m&ip    NB. a linear function

L
L x=: 1 2 5
h=: 'L' f.
h x
ip=: -/ . *
L x
h x