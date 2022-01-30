Note
set notation | interval notation | description of interval
{x| a<x<b }  | (a , b)           | open
{x| a<x*b }  | (a , b]           | half-open on the left
{x| a*x<b }  | [a , b]           | half-open on the right
{x\ a*x*b }  | [a , b]           | closed

{x| a<x }    | (a , _)           | x greater than a
{x| x<b }    | (__, b)           | x less than b
R            | (__, _)           | x all finite real numbers
{x| x*b }    | (__, b]           | x less than or equal to b
{x| a*x }    | [a , _)           | x greater than/equal to a
{a}          | [a , a]           | x equal to a
{}           | (a , a)           | x is the empty set
)

d0=: OO=: ({.@] <  [)*.([ <  {:@]) NB. x OinO y (Is x in open interval y)
d1=: OC=: ({.@] <  [)*.([ <: {:@]) NB. x OinC y
d2=: CO=: ({.@] <: [)*.([ <  {:@]) NB. x CinO y
d3=: CC=: ({.@] <: [)*.([ <: {:@]) NB. x CinO y

d4=: +/"1@d2                       NB. Number of x OinC y
d5=: 0: e.~ class                  NB. x OinO y
d6=: 0 1"_ e.~ class               NB. x OinC y
d7=: _1 0"_ e.~ class              NB. x CinO y
d8=: _1 0 1"_ e.~ class            NB. x CinC y
d9=: class=: [: +/"1 [: * -/       NB. Class _2 to 2:<A="a" CINC="b">b
d10=: [: ~:/ >:/~                  NB. x OinC y
d11=: ] >/ .>~ [: ,.~ [            NB. x OinC y

d12=: sgd=: *@(-~/~)               NB. Signum of difference
d13=: 0&=@(+/)@sgd                 NB. OO
d14=: e.&0 1@(+/)@ sgd             NB. OC
d15=: 0&>:@(%/)@sdg                NB. CO
d16=: >/@sdg                       NB. CC

X=: i.12 [ Y=: 3 8
X ([ , OO , OC , CO ,: CC) Y

X(CC = OC +. CO) Y                 NB. Tautology
X (d5 = OO) Y
X ,: X d9 Y
X d12 Y