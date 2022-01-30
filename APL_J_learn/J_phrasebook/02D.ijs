a0=: I=: ^:_1  NB. Inverse (^I is ^.)
a1=: L=: ^:_   NB. Limit (2&o.L 1 for soln of y=cos y)
a2=: LI=: ^:__ NB. Limit of inverse
a3=: SQ=: ^:2  NB. Square (1&o.SQ for sine squared)
a4=: C=: &o.   NB. Family of circular fns (3 C is tangent)
a5=: CO=: %@C        NB. 3 CO is cootangent
m6=: rfd=: 1r180p1&* NB. Radians to degrees
m7=: dfr=: rfd I f.  NB. Using f. to fix definition
a8=: D=: @rfd        NB. Try 1 C D 0 30 45 60 90 180

1 C D 0 30 45 60 90 180

m9=: SIN=: 1&o. D    NB. Sine for degree arguments
a10=: T=: "2         NB. Try <T i.2 3 4 3 (BOX TABLES)

<T i. 2 3 4 3

a11=: S=: ^!.        NB. Stope (rising or falling factorial fn etc)
a12=: P=: p.!.       NB. Stope polynomial
a13=: FILL=: |.!.    NB. Fill for shift(non-cyclic rotate)
a14=: FILE=: 1!:     NB. File functions (1 FILE for read, etc.)

c15=: split=:conjunction : '[:,.(u@(n&{.) ; u@(n&}.))'
]s=: i. 5 3
(+: split 2)s

(+:split 2   ,.   |.split 3   ,.   +/split 2) s

d16=: by=: ''&;@,.@[,.]
d17=: over=:({.;}.)@":@,
a18=: table=: adverb :'[ by ] over u/' NB. Try 1 2 3 * table 4 5 6 7

1 2 3 * table 4 5 6 7

a=: 0 0 1 1 [ b=: 0 1 0 1
a *. b       NB. Boolean and

a 1 b. b     NB. Boolean adverb

a (i.16)b. b NB. all sixteen Boolean functions

C=: adverb : 'u&o.'         NB. Circle adverb
1 C 0 1r4p1 1r3p1 1r2p1 1p1 NB. Sine function

^&3 x=: i.6  NB. Cube
2 |.!. 1 x   NB. Shift in ones

a=: 1 4 6 4 1 [ b=: 1 2 1
RAT=: conjunction : 'u&p. %&:x: v&p.'
a RAT b

a RAT b c=: i.6
b RAT a c

(a RAT b * b RAT a) c

X=: conjunction : 'm&* @ (^&n) "0'
2 X 3
2 X 3  input=: 0 1 2 3 4 5
2 * input ^ 3
2 3 5 X 1 2 4 input

X=: conjunction : '+/ @ (m&* @ (^&n)) "0'
2 3 5 X 1 2 4 input

(2 X 1  +  3 X 2  +  5 X 4) input

2 X 3 input



c19=: RAT=: conjunction : 'u&p. %&:x: v&p.'     NB. Produces rational function
c20=: X=: conjunction : '+/ @ (m&* @ (^&n)) "0' NB. Mimics notation of elementary math
c21=: bind=: adverb : 'u@n' NB. binds n to monad u

