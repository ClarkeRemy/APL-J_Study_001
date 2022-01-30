NB. Check out these operators
NB. S: L: {::
NB. Parent Sibling are separate vectors?
NB. ⎕IO←0

NB. DFPT :: Depth First Preorder Traversal
NB. ADT  :: Abstract data Type

NB. APL (c.f. ⎕XML/⎕JSON)
NB. ]boxing on

NB.        p    p      p   p          p  p        p
NB. adt ←  0   (1 2)  (3  (4 5)  6) ( 7 (8 9 10) (11 12 13) 14)
   ]Adt=:  0 ; (1 2); (3 ;(4 5); 6);(<7;(8 9 10);(11 12 13);14)
NB. Identifiers are the enlist
NB. ids ← ∊adt ⍝ ⍳15
    enlist=: ;<@,S:0 
    ids =: enlist Adt
NB. depth vector
NB. d ← 0 1 2 1  2 3 2 1   2 3  3  2   3  3  2
   ]D=: 0 1 2 1  2 3 2 1   2 3  3  2   3  3  2
NB. PATH MATRIX
NB.     0 0 0 0  0 0 0 0   0 0  0  0   0  0  0
NB.       1 1 3  3 3 3 7   7 7  7  7   7  7  7
NB.         2    4 4 6     8 8  8 11  11 11 14
NB.                5         9 10     12 13

NB. PARENT/SIBLING (left sibling)
NB.     0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
NB. p ← 0  0  1  0  3  4  3  0  7  8  8  7 11 11  7
NB. l ← 0  1  2  1  4  5  4  3  8  9  9  8 12 12 11

NB. Adding    ,←
    adding =. , NB. maybe ,. or ,:
NB. parent vector does not need to be ordered
NB. "p or l as left argument" "child to root node p,←0"


NB. Deleting ← (⍸M)(⊢-1+⍸)(~M)⌿P
NB. M is a Mask                      
    deleting =:(I.M)     (]-1+I.)        (-.M)#P
    NB.        ToDel   recomputeindex    ToKeep  

NB. Using @ (⎕IO←0)
NB. (10 20 @ 1 3) ⍳5
NB.  10 20 @ 1 3  ⍳5
     10 20 (2 4)} i.5
NB. (⊂⍬)@1 3 ⍳¨⍳5
    a: 1 3} <@i."0 i.5
NB. (2 3⍴10 20)(@1 3) 4 3⍴⍳12
    (2 3$10 20)(1 3}) 4 3$i.12
NB. (0@(0 0)(3 2)) 4 3⍴⍳12
     0 (0 0;3 2)} 4 3$i.12

NB. G ← (('ABC' 1) ('DEF' 2) ('GHI' 3)) ⍪[¯0.5] (('JKL' 4)('MNO' 5)('PQR' 6)) 
    ]G=: (('ABC';1);('DEF';2);<('GHI';3)) ,: ( ('JKL';4);('MNO';5);<('PQR';6) ) 
NB. G[ ((0 1) 0) ((1 2) 1) ]
NB.  ((0 1) 0) ((1 2) 1) ⊃¨⊂ G
    ((0 1; 0) ;< (1 2;1))  {::&.(>`a:)  G 

NB. ÷@1 3 ⍳5
    (1 3 }~ [: %  (1 3&{) )  i.5

    AT=: {{ n}~ u@:(n&{) }}   :   {{ ] n}~ (u (n&{)) }} 
    
    %AT 1 3 i.5
    10 - AT 1 3 (10+i.5) NB. dyad

     




NB. Idioms
NB. Chipmunk (dyadic ::   ReachIndex chipmunk Tree) 
NB. ⊃¨⊂
    {::&.(>`a:) 
NB. f@vec
    AT=: {{ n}~ u@:(n&{) }}   :   {{ ] n}~ (u (n&{)) }} NB. f AT vec

NB. +/¨@2 4 ⍳¨⍳5
    +/&.> AT 2 4  <@i."0 i.5

NB. (+\@1 3)4 3⍴⍳12
    (+/\"1 AT 1 3) i. 4 3

NB. 0@(2∘|)⍳5
    0  I.@:(2&|)@:] } i.5

NB. 'abcdef'@{0=3|⍵} 4 4⍴⍳16
    idxAPL   =: {{  {<@(i."0)$y            }} NB. Monadic
    boolIdx  =:  >@:#&:, idxAPL                NB. Monadic Hook
    AmmendIf =: {{  [`(boolIdx@:u@:])`] }  }} NB. Adverb -> Dyad
    'abcdef' (0= 3| i.@:$) AmmendIf  4 4$'ABCDEFGHIJKLMNOP'