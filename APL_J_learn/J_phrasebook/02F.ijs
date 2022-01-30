m0=: It=: =<.     NB. Integer test
m1=: Rt=: =+      NB. Real    test
d2=: $,:          NB. x copies of y
d3=: $,           NB. Reshape as in APL
m4=: cf=: (+%)/   NB. Continued fraction
m5=: cfc=: (+%)/\ NB. Continued fraction convergents
m6=: ifb=: # i.@# NB. Integers from boolean list
m7=: [M           NB. ([M)y invokes M y (then returns y)

cf  3 7 15 1
cfc 3 7 15 1
cfc 1 1 1 1 1 1 1
cfc 10$1x
