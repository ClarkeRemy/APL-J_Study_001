⎕IO ← 0 ⍝ required for consistancy with J, Apl expressions must be changed accordingly.
⍝ there will be regular reminders of this

⍝ APL and J following Mastering Dyalog APL
⍝ APL done in Nars2000
⍝ needs Dyalog testing, Nars2000 requires parrens for tacit functions, Dyalog does not
⍝ similarly (/¨) requires parens for parsing the definition; the system removes them
⍝ when using ⎕CR 'func' display 

⍝ I'm doing this to practice writing tacit syntax and learn APL

⍝ Because Mastering APL naturally doesn't explain J,
⍝ I will explain some basics of J.

⍝ Variable assignment
⍝ in APL then in J:
AplVar ← 1
⍝ JVar =: 1
⍝
⍝ with shape:
AplArray ← 2 2 ⍴ 1 1 1 1
⍝ JArray =: 2 2 $ 1 1 1 1

⍝ Definition 
⍝ 
⍝ APL             | J
⍝-----------------+--------------------- 
⍝ trdfn           | explicit definition
⍝  ∇ r ← x func y |  func =: 3 : 'x + y'  NB. the space after the 3 is required
⍝    r ← x + y    | or                    NB. in J, x and y are implictly there
⍝  ∇              |  func =: 3 : 0        NB. with n : 0 a multiline is possible
⍝                 |      x + y
⍝                 |      )
⍝ https://aplwiki.com/wiki/Defined_function_(traditional)
⍝ https://www.jsoftware.com/help/dictionary/d310n.htm
⍝ 
⍝ dfn             | direct definition
⍝    func ← {⍺+⍵} |     func =: {{x+y}}   NB. In J this is sugar for
⍝          *[ DISPLAY ]*                  NB. explict definition.
⍝    ⎕CR 'func'   |     func              NB. notice how it auto selects the 
⍝ func{           | 4 : 'x+y'             NB. definition type (4 : n)= dyad
⍝ ⍺+⍵             |                       NB. 'x+y' is parsed as a string
⍝ }               |                       NB. directly in the interpretter
⍝ https://aplwiki.com/wiki/Dfn
⍝ https://code.jsoftware.com/wiki/Vocabulary/DirectDefinition
⍝
⍝ tacit           | tacit definition
⍝ avg ← (+⌿ ÷  ≢) | avg =: +/ % #         NB. Tacit functions/verbs fork!
⍝        1  2  3  |        1  2 3         NB. Forks come in 3s
⍝ *[read as: Average is Sum divides tally]*     
⍝ dfnAvg←{        | ddAvg=:{{             NB. DirectDefinition version
⍝   (+⌿⍵r) ÷ ≢    |    (+/y) % #y
⍝   }             |    }}
⍝                 |                       NB. 
⍝ (dfnAvg=avg)list| (ddAvg=avg)list       NB. A for proving equivalent
⍝                 |                       NB. functions with a fork
⍝ *[ Beware of HOOKS! they come in 2s.]*
⍝ ((÷÷)c) ≠ ÷÷c   | ((%%)c) ~: %%c        NB. c here is just a value 
⍝                 |                       NB. 
⍝                 |                       NB. 
⍝(dfnAvg=(+⌿ ÷ ≢))| (ddAvg=(+/ % #))      NB. A hook on a fork makes a new fork
⍝  (1   2|1  2 3) |   (1  2|1  2 3)
⍝   1   2 ^3FORK^ |  ^HOOK^ ^FORK^        ⍝ APL does not have Hooks
⍝ ^            ^  |  ^           ^
⍝  \   FORK   /   |   \   FORK  / 
⍝                 |
⍝                 | bool =:   = ^&2       NB. This hook is equivalent to this
⍝ bool ← (⊢ = *∘2)| bool =: ] = ^&2       NB. fork. I reccommend making forks
⍝                 |                       NB. instead of hooks where possible.
⍝
⍝ Forks are the most import part to grasp when doing Tacit programming 
⍝ in APL and J. However to do it neatly, you need Composition.
⍝ A must read:
⍝ https://code.jsoftware.com/wiki/Vocabulary/fork
⍝ on avoiding hooks:
⍝ https://code.jsoftware.com/wiki/Essays/Hook_Conjunction%3F


⍝01============================================================================


⍝ P.5/27
  VAT ← 19.6
  Years ← 1952 1943 1986 2007
  Price ← 5.2 11.5 3.6 4 8.45
  Qty ← 2 1 3 6 2
⍝ VAT =: 19.6                   NB. J
⍝ Years =: 1952 1943 1986 2007  NB. J
⍝ Price =: 5.2 11.5 3.6 4 8.45  NB. J
⍝ Qty =: 2 1 3 6 2              NB. J

  Costs ← Price × Qty        ⍝ NB. J  × is *

⍝ P.6/28
  Forecast ←  4 6 ⍴ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350
  Actual   ←  4 6 ⍴ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363
⍝ Forecast =: 4 6 $ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350  NB. J
⍝ Actual   =: 4 6 $ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363  NB. J

  Actual - Forecast

⍝ P.7/29
  addedCost ←  {⍺×⍵÷100}
  addedCost ←  (100 ÷⍨ ×)
⍝ addedCost =: {{ x*y%100 }}  NB. J
⍝ addedCost =: * % 100"_    NB. J
  Price addedCost VAT

75.6 ⌈ 87.3               ⍝ >. in J
11 28 52 14 ⌈ 30 10 50 20
11 28 52 14 ⌊ 20          ⍝ <. in J

⍝ P.8/30
  Tab ←  4 2 ⍴ 25 60 33 47 11 44 53 28
⍝ Tab =: 4 2 $ 25 60 33 47 11 44 53 28  NB. J

⍝ P.9/31
  Costs ←  10.4 11.5 10.8 24 16.9
⍝ Costs =: 10.4 11.5 10.8 24 16.9  NB. J

⍝ P.10/32
  Val ←  22 37 41 19 54 11 34
⍝ Val =: 22 37 41 19 54 11 34      NB. J

  Average ← {(+/⍵)÷ ⍴⍵}
  Average ← (+/ ÷ ⍴)               ⍝      (+⌿⍤(1)÷≢) 
⍝ Average =: {{ (+/"1 y)% $y }}    NB. J  / in J is like APL ⌿
⍝ Average =: +/"1 % $              NB. J  +/"(1) %#
  Average Val

⍝ P.11/33
⍝ Because Indexing is wierd, more attention here

⎕IO ← 0            ⍝ reminder, the book uses ⎕IO ← 1 , using 0 to be like J
  Val[3]
  3⌷Val
⍝ Val =: 3 } Val   NB. J
  Val[1 3 6 0 4]
  (⊂1 3 6 0 4)⌷Val
⍝  1 3 6 0 4 } Val NB. J

⍝ P.12/34
⎕IO ← 0
  Val[2 4 0] ← 0
  Val ← (0 @ 2 4 0)Val    ⍝ Okay in Dyalog, not NARS2000
⍝ Val =: 0 (2 4 0) } Val           NB. J
  Val[2 4 0] ← 300 77 111                                
⍝ Val =: 300 77 111 (2 4 0) } Val  NB. J

⍝ P.13/35
⍝ I am using the variables in book, not the Dyalog system, 
⍝ so the results will be different.
  Salaries   ←  4225 1619 3706 2240 2076 1389 3916 3918 4939 2735
  Categories ←  3    1    3    2    2    1    3    3    3    2 
⍝ Salaries   =: 4225 1619 3706 2240 2076 1389 3916 3918 4939 2735  NB. J
⍝ Categories =: 3    1    3    2    2    1    3    3    3    2     NB. J

⍝ becasue Categories is for indexing,  I will add a category "0",
⍝ so rates will have a 0 appended for ⎕IO ← 0
  Rates ←  0 , 8 5 2 ÷ 100
⍝ Rates =:  0 , 8 5 2 % 100  NB. J

  Rates[Categories]
  (⊂Categories)⌷Rates
⍝ Categories   {Rates                        NB. J
  Raises ← Salaries × Rates[Categories]
  Raises ← Salaries × (⊂Categories)⌷Rates
⍝ Raises =: Salaries * Categories { Rates   NB. J

⍝ P.14

  Categories{(⍺=3)∧(⍵<4000)}Salaries
  Categories((3=⊣) ∧ 4000>⊢)Salaries     ⍝ 4000<⍨⊢ also possible
  Categories(3∘=⍤⊣ ∧ 4000>⊢)Salaries     ⍝ Ok in Dyalog, Nars2000 ⍤ is only rank
⍝ Categories{{ (x=3)*.y<4000 }}Salaries     NB. J
⍝ Categories(3&=@:[ *.  4000>])Salaries NB. J  compare with Dyalog variant

⍝ P.15/37
  Salaries{+/ ⍺<⍵}2500
  Salaries(+/<)2500
⍝ Salaries{{+/"1 x<y}}2500   NB. J the "1 is there to remind us that
⍝ Salaries([: +/"1 <)2500    NB. J it's not the same

  1 1 0 1 0 0 1 / 23 55 17 46 81 82 83
⍝ 1 1 0 1 0 0 1 # 23 55 17 46 81 82 83 NB. J
  1 0 1 0 0 0 0 1 1 / 'Drumstick'
⍝ 1 0 1 0 0 0 0 1 1 # 'Drumstick'      NB. J

  Categories{(⍺=2)/⍵}Salaries
  Categories(⊢ (/⍨) 2=⊣)Salaries
⍝ Categories{{(x=2) # y}}Salaries NB. J
⍝ Categories(] #~ 2=[)Salaries    NB. J

⍝ P.16/38
  Val ←  22 37 41 19 54 11 34
⍝ Val =: 22 37 41 19 54 11 34  NB. J
  {(⍵>35) / ⍳⍴⍵}     Val
  (>∘35 (/¨) ⍳∘⍴)    Val
⍝ {{ (x>35) # i.$y }}Val  NB. J
⍝ (>&35 # [: i.$)    Val  NB. J

  Phrase ← 'Panama is a canal between Atlantic and Pacific'
⍝ Phrase =: 'Panama is a canal between Atlantic and Pacific'
  aIndecies ←  {(⍵='a') / ⍳⍴⍵}
  aIndecies ←  (=∘'a'(/¨)⍳∘⍴)
⍝ aIndecies =: {{(y='a') # i.$y}} NB. J
⍝ aIndecies =: =&'a' # [: i.$      NB. J
aIndecies Phrase

  5 7 2 8 4 9 ∊ 3 4 5 6
⍝ 5 7 2 8 4 9 e. 3 4 5 6
  'dandelion' ∊ 'garden'
⍝ 'dandelion' e. 'garden'

⍝ P.17/39
  vowelIndecies ← {(⍵∊'aeiouy') / ⍳⍴ ⍵}
  vowelIndecies ← (∊∘'aeiouy'(/¨)⍳∘⍴)
⍝ vowelIndecies =: {{(y e.'aeiouy') # i.$y}} NB. J
⍝ vowelIndecies =: e.&'aeiouy' # [: i.$       NB. J
vowelIndecies Phrase

  Towns ←  6 10 ⍴ 'Canberra  ','Paris     ','Washington','Moscow    ','Martigues ','Mexico    '
⍝ Towns =: 6 10 $ 'Canberra  ','Paris     ','Washington','Moscow    ','Martigues ','Mexico    '

  List  ← 15 40 63 18 27 40 33 29 40 88
  Where ← 29 63 40 33 50
⍝ List  =: 15 40 63 18 27 40 33 29 40 88  NB, J
⍝ Where =: 29 63 40 33 50                 NB, J
  PlacedIn ← {(⍵∊⍺)/⍳⍴⍵}
  PlacedIn ← (∊⍨(/¨)⊢∘⍳∘⍴)
⍝ PlacedIn =: {{(y e.x)#i.$y}}  NB, J
⍝ PlacedIn =: e.~ # [: i.$@:]   NB, J
Where PlacedIn List

⍝ P.18/40
  D ← 84
  Area ← 17 50 59 84 89
  Discount ← 9 8 6 5 4 2
⍝ D =: 84                 NB, J
⍝ Area ← 17 50 59 84 89   NB, J
⍝ Discount ← 9 8 6 5 4 2  NB, J

  D ∊ Area               ⍝ D e.Area   NB. J
  Area ⍳ D               ⍝ Area i. D  NB. J

⍝ P.19/41
  ⎕IO ← 0                ⍝ reminder
  Discount[3]
  3⌷Discount             
⍝ 3{Discount NB. J

  Discount[Area⍳D]
  (⊂Area⍳D)⌷Discount     
⍝ (Area i.D){Discount  NB, J

  D ← 24 75 89 60 92 50 51 50 84 66 17 89
⍝ the above still works with an array

  AlphLower ← 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  AlphUpper ← 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ*'
  
  Tale ← 'Le Petit Chaperon-Rouge a bouffé le Loup'
  
  AlphUpper[AlphLower⍳Tale]
  (⊂AlphLower⍳Tale)⌷AlphUpper 
⍝ (AlphaLower i. Tale){AlphaUpper  NB. J DOMAIN ERROR

⍝ P.20/42

⍝ P.21/43 
  Tome ←  56 59 67 64 60 61 68 73 78 75 81 84
⍝ Tome =: 56 59 67 64 60 61 68 73 78 75 81 84  NB. J
  DifBtwnYears ← {(1↓⍵)-(¯1↓⍵)}
  DifBtwnYears ← (1∘↓ - ¯1∘↓)
⍝ DifBtwnYears =: {{ (1}.y)-(_1}.y) }} NB. J
⍝ DifBtwnYears =: 1&}. - _1&}.         NB. J
DifBtwnYears Tome

  Growth ← {100×((1↓⍵)÷(¯1↓⍵))-1}
  Growth ← (100× 1-⍨ 1∘↓ ÷ ¯1∘↓)
⍝ Growth =: {{ 100*((1}.y)%(_1}.y))-1 }} NB. J 
⍝ Growth =: 100* 1-~ 1&}. % _1&}.        NB. J  notice the capped fork
Growth Tome

⍝ P.22/44
  Towns ←  6 10 ⍴ 'Canberra  ','Paris     ','Washington','Moscow    ','Martigues ','Mexico    '
⍝ Towns =: 6 10 $ 'Canberra  ','Paris     ','Washington','Moscow    ','Martigues ','Mexico    '  NB. J

⍝ use rank with reverse for ⌽ and ⊖ in J! (|."n)
⌽Towns    ⍝ |."1 Towns NB. J
⊖Towns    ⍝ |.Towns    NB. J
⍉Towns    ⍝ |:Towns    NB. J

⍝ P.23/45

5 4 10 3 ∘.× 8 5 15 9 11 40
⍝ 5 4 10 3 */ 8 5 15 9 11 40  NB. J

(∘.<⍨⍳)5     ⍝ (</~@:i.)5     NB. J
(∘.>⍨⍳)5     ⍝ (>/~@:i.)5     NB. J
(∘.⌈⍨⍳)5     ⍝ (>./~@:i.)5    NB. J

Plus ← +     ⍝ Plus =: +      NB. J
(∘.Plus⍨⍳)5  ⍝ (Plus/~@:i.)5  NB. J

⍝ P. 24/46
  Ages     ←  32 19 50 33 23 65 46 26 31 58 51 23 51 36 28 42 34
  Category ←  0 25 30 35 45 50 55 65
⍝ Ages     =: 32 19 50 33 23 65 46 26 31 58 51 23 51 36 28 42 34
⍝ Category =: 0 25 30 35 45 50 55 65

Category ∘.< Ages  ⍝ Category </ Ages NB. J

⍝ P.25/47

  cum ← Category{+/ ⍺ ∘.< ⍵}Ages
  cum ← Category(+/ ∘.<)Ages 
⍝ cum =: Category{{ +/"1 x</y }}Ages  NB. J
⍝ cum =: Category([: +/"1 </)Ages     NB. J

{⍵- 1↓⍵,0}cum    ⍝ {{ y- 1}. y,0 }}cum 
(⊢- 1↓ ,∘0)cum   ⍝ (]- 1}. ,&0)cum

  GrpTallyBy ← {{⍵- 1↓⍵,0} +/ ⍺ ∘.< ⍵}
  GrpTallyBy ← ((⊢- 1↓ ,∘0) (+/ ∘.<))
  GrpTallyBy ← (⊢- 1↓ ,∘0)⍤(+/ ∘.<)            ⍝ possible in Dyalog
⍝ GrpTallyBy =: {{ z- 1}. 0,~z=. +/"1 x</y }}  NB. J
⍝ GrpTallyBy =: [: (]- 1}. ,&0) [: +/"1 </     NB. J
Category GrpTallyBy Ages


⍝02============================================================================


⍝ P.44/66
  Discount  ←  0.15 
  Years     ←  1952 1943 1956 2007
  Purchased ←  4000
⍝ Discount  =: 0.15 
⍝ Years     =: 1952 1943 1956 2007
⍝ Purchased =: 4000

⍝P P.46/68
Amount ← Purchased×Discount ⍝ Amount =: Purchased*Discount NB. J

  (G H J) ←  30 51 49
⍝ 'G H J' =: 30 51 49   NB. J  the parrens notation is a syntax error

  (Colette Bernard Line Now) ←  Years
   Colette Bernard Line Now  ←  Years  ⍝ OK in Dyalog, not Nars2000
⍝ 'Colette Bernard Line Now' =: Years  NB. J

⍝ P.47/69
  Sales ←  6 1 8 12 3 3 5 4 7 9
⍝ Sales =: 6 1 8 12 3 3 5 4 7 9

Month      ←  6 8 ⍴ 'January ','February','March   ','April   ','May     ','June    '
Income     ←  4210 4807 3609 5712 2305 4568
Expenses   ←  3121 4284 7543 2601 3364 2784
⍝ Month    =: 6 8 $ 'January ','February','March   ','April   ','May     ','June    ' NB.J
⍝ Income   =: 4210 4807 3609 5712 2305 4568  NB. J
⍝ Expenses =: 3121 4284 7543 2601 3364 2784  NB. J

⍝ P.48/70
  Money ←  6 2 ⍴ Income , Expenses 
⍝ Money =: 6 2 $ Income , Expenses NB. J
  Contents ←  12 56 78 74 85 96 30 22 44 66 82 27
⍝ Contents =: 12 56 78 74 85 96 30 22 44 66 82 27

⍝ P.49/71
⍝ Someone please tell me there is a better way to write out many numbers nicely
PR01 ← 26 16 22 17 21 44 25 22 23 44 41 33
PR02 ← 43 36 47 49 30 22 57 20 45 60 43 22
PR03 ← 44 21 58 57 17 43 47 17 43 26 53 23
PR04 ← 29 19 23 38 53 47 38 22 40 57 35 26
PR05 ← 37 27 53 26 29 46 25 26 30 20 32 16
PR06 ← 56 55 25 47 38 27 39 59 20 28 42 25
PR07 ← 21 57 55 44 16 54 26 16 55 56 45 45
PR08 ← 16 55 26 20 27 55 36 39 43 38 50 16
PR09 ← 27 23 56 41 53 60 39 47 44 47 17 28
PR10 ← 24 35 61 26 22 35 24 20 31 35 47 37
Prod ← 5 2 12 ⍴ PR01,PR02,PR03,PR04,PR05,PR06,PR07,PR08,PR09,PR10

⍝ In J it can be done like so
⍝
⍝    Prod =: 5 2 12 $, (". ;. _2) 0 : 0
⍝ 26 16 22 17 21 44 25 22 23 44 41 33
⍝ 43 36 47 49 30 22 57 20 45 60 43 22
⍝ 44 21 58 57 17 43 47 17 43 26 53 23
⍝ 29 19 23 38 53 47 38 22 40 57 35 26
⍝ 37 27 53 26 29 46 25 26 30 20 32 16
⍝ 56 55 25 47 38 27 39 59 20 28 42 25
⍝ 21 57 55 44 16 54 26 16 55 56 45 45
⍝ 16 55 26 20 27 55 36 39 43 38 50 16
⍝ 27 23 56 41 53 60 39 47 44 47 17 28
⍝ 24 35 61 26 22 35 24 20 31 35 47 37
⍝ )
⍝
⍝ the definition ends with the )
⍝ the 0 : 0 makes a string from what follows till )
⍝ the idiom (". ;. _2) will parse it into a table
⍝ then shape after ravel (5 2 12 $,)

⍝ or
  Prod ←  5 2 12 ⍴ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37
⍝ Prod =: 5 2 12 $ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37 NB. J

⍝ P.50/72
Shape ← ⍴  ⍝ Shape =: $    NB. J
Rank  ← ⍴⍴ ⍝ Rank  =: $$   NB. J  
Rank  ← ≢⍴ ⍝ Rank  =: #$   NB. J

⍝ reminders:
⍝ - APL ⍴ and J $ return blank for scalar, but (⍴⍴) ($$) and (#$) return 0
⍝ - Shape is always a vector
⍝ - careful when in doubt, check the shape
V ← 87 65 21 40
M ← 1 4 ⍴ 87 65 21 40
⍝ the two above output the same in the repl
⍝ - scalar is not the same a one item vector

⍝ P.53/73
  Bignum ← 446.19 231.12 253.59 115.56 262.15 271.78 1.07 180.83 166.92 318.86 240.75 44.94 240.75 90.95 317.79 285.69 4.28 368.08 295.32 379.85 324.21 77.04 77.04 415.16 447.26 33.17 415.16 285.69 202.23 126.26 180.83 81.32 134.82 261.08 343.47 157.29 335.98

  Text ← 'Today is August 14th, 2007'
  Trailer ← 'I type 7 trailing blanks'
  Damned ← 'It''s raining, isn''t it?'
  Hundred ← '100'
  Singleton ← 'P'

⍝ P.55/77
  MonMat ← 6 8 ⍴ 'January FebruaryMarch April May June'
  MonMat ← 6 8 ⍴ 'January FebruaryMarch April May June    ' ⍝ spaces at the end

  MonVec ← 'January' 'February' 'March' 'April' 'May' 'June' ⍝ nested array
⍝ MonVec =: 'January';'February';'March';'April';'May';'June' NB. J  
⍝ this is boxed, J only has Flat arrays

  Contents ←  12 56 78 74 85 96 30 22 44 66 82 27
⍝ Contents =: 12 56 78 74 85 96 30 22 44 66 82 27
  ⎕IO ← 0
  Contents[2]
  2⌷Contents     ⍝ 2{Contents  NB. J

⍝ P.57/79
  Contents[2 6 0 2 2 11]
  (⊂ 2 6 0 2 2 11)⌷Contents
⍝  2 6 0 2 2 11   {Contents    NB. J

  Contents[1 3 5] ← 7 11 80
  Contents ← (7 11 80 @ 1 3 5)Contents  ⍝ Okay in Dyalog
⍝ Contents =: 7 11 80 (1 3 5)} Contents NB. J

  Contents[7 10 11] ← 33
  (33 @ 7 10 11)Contents     ⍝ Okay in Dyalog
⍝  33 (7 10 11)} Contents    NB. J

  'COMPUTER'[7 6 3 1 7 5]
  (⊂ 7 6 3 1 7 5)⌷'COMPUTER'
⍝ 7 6 3 1 7 5 { 'COMPUTER'   NB. J

  Test ←  'BREAD'
⍝ Test =: 'BREAD'

  Test[1 3] ← 'LN'
  Test ← ('LN' @ 1 3)Test
⍝ Test =: 'LN' (1 3)}Test    NB. J

  Contents ←  12 56 78 74 85 96 30 22 44 66 82 27
⍝ Contents =: 12 56 78 74 85 96 30 22 44 66 82 27

⍝ P.58/80
  MyIndex ←  3 5 ⍴ 5 5 4 4 8 6 12 6 11 12 10 6 1 4 9 - 1 ⍝ - 1 for ⎕IO ← 0
⍝ MyIndex =: 3 5 $ 5 5 4 4 8 6 12 6 11 12 10 6 1 4 9 - 1

  Contents[MyIndex]
  (⊂MyIndex)⎕Contents
⍝ MyIndex { Contents

  Planning ←  5 12 ⍴ 0 0 0 1 1 1 1 1 1 0 0 0,1 1 1 1 1 1 1 1 0 0 0 0,0 1 1 1 0 0 0 0 0 1 1 1,0 0 0 0 0 0 0 1 1 1 1 1,0 0 1 1 1 1 1 0 0 0 0 0
⍝ Planning =: 5 12 ⍴ 0 0 0 1 1 1 1 1 1 0 0 0,1 1 1 1 1 1 1 1 0 0 0 0,0 1 1 1 0 0 0 0 0 1 1 1,0 0 0 0 0 0 0 1 1 1 1 1,0 0 1 1 1 1 1 0 0 0 0 0

  '-⎕'[Planning]
  (⊂Planning)⌷'-⎕'
⍝ Planning { '-@'  NB. J the Quad character doesn't display

  Tests ← 6 3 ⍴ 41 26 38,14 87 52,30 28 19,65 40 55,19 31 64,45 82 74
⍝ Tests =: 6 3 $ 41 26 38,14 87 52,30 28 19,65 40 55,19 31 64,45 82 74 NB.J

⍝ P.59/81
⎕IO ← 0
  Tests[3;2]
  3 2⌷⍤(1 99) Tests
  (⊂3 2)⊃     Tests
⍝ 3 2 {       Tests   NB. J
  Tests[0 4 5;0 2]
  (0 4 5)(0 2)⌷⍤(1 99) Tests
⍝ (<0 4 5; 0 2){Tests NB. J
  Tests[0 1 4 5;0]
  (0 1 4 5) 0 ⌷⍤(1 99) Tests
⍝ (<0 1 4 5; 0){Tests NB. J

⍝ find Prod at P.49/71
  Prod[3 4;1;0 1 2 3 4 5]
  (3 4) 1 (⍳6)⌷⍤(1 99)Prod
⍝ (<3 4;1;i.6){Prod   NB. J

⍝ P.60/82
  Tests[(1 2)(4 0)(0 1)]
⍝ ? a better way in APL?
⍝ (1 2;4 0;0 1){Tests NB. J

  Prod[3 4;;0 1 2 3 4 5]
⍝ ? a better way in APL?
⍝ (<3 4;(<0$0);0 1 2 3 4 5){Prod  NB. J both 0$0 and '' are "empty"
⍝ (<3 4;(<'');0 1 2 3 4 5){Prod   NB. J
⍝ (<3 4;a: ;0 1 2 3 4 5){Prod     NB. J using ace is best
  Prod[3 4;1;] 
  (3 4)1⌷⍤(1 99)Prod ⍝ the last value is uneeded in this specific case
⍝ (<3 4;1){Prod                   NB. doesn't work with (<0$0) at the end
  Prod[;;0 1 2] 
⍝ ? a better way in APL?
⍝ (<a: ; a: ;0 1 2){Prod
  Tests[5;] ← 60 70 80
⍝ Tests=: (60 70 80)(<5)}Tests   NB. J

⍝ P.61/83
  Tests[0 5;0 2] ← 2 2 ⍴ 11 22 33 44
⍝ ? a better way in APL?
⍝ Tests=: (2 2$11 22 33 44) (<0 5;0 2) } Tests  NB. J

  Tests[;] ← 0 
  Vector[] ← 123
⍝ Tests=: 0 a: }Tests  NB. J

⍝ P.62/84
  Vec ←  32 51 28 19 72 31
⍝ Vec =: 32 51 28 19 72 31  NB. J

  Res ← Vec[1 3 5] ← 50
⍝ !! Vec has been changed, Res is 50 and  not Vec !! (Pass-through)

  (2⌷Contents) = Contents[2]
⍝ 2{Contents
  3 1 ⌷ Tests
⍝ (<3;1) { Tests
  (0 2 5)(0 2)⌷Tests
⍝ (<0 2 5;0 2) { Tests

⍝ P.63/85
  MixVec ← 44 87 'K' 12 29 'B' 'a' 'g' 46.3
⍝ MixVec =: 44;87;'K';12;29;'B';'a';'g';46.3   NB. J
  MixMat ← 2 5 ⍴ MixVec
⍝ MixMat =: 2 5 $ MixVec  NB. J

⍝ P.64/86
  One ←  2 2⍴8 6 2 4 ⋄ Two ← 'Hello'
⍝ One =: 2 2$8 6 2 4 [ Two =: 'Hello'           NB. J

⍝ P.65/87
  NesVec ←  87 24 'John' 51 (78 45 23) 85 One 69
⍝ NesVec =: 87;24;'John';51; 78 45 23; 85;One;69  NB. J
  NesMat ←  2 3 ⍴ 'Dyalog' 44 Two 27 One (2 3⍴1 2 0 0 0 5)
⍝ NesMat =: 2 3 $ 'Dyalog';44;Two;27;One; 2 3$1 2 0 0 0 5   NB. J

⍝ P.66/88
⍝ Check DISPLAY definition
  DISPLAY 54 73 19
  0 DISPLAY 54 73 19
⍝ < 54 73 19      NB. J     boxing in J always displays the box
⍝                 NB. J     Need to find out how to do with standard characters

⍝ P.69/91
  Weird ← 2 2⍴ 456 ((0 1)(0 1)⌷⍤(1 99)NesMat) (17 51) 'Twisted'
⍝ Weird =: 2 2$ 456; ((<;~0 1){NesMat) ; 17 51; 'Twisted'     NB. J

  MonVec ← 'January' 'February' 'March' 'April' 'May' 'June' ⍝ nested array
⍝ MonVec =: 'January';'February';'March';'April';'May';'June' NB. J  
  DISPLAY MonVec
⍝ MonVec        NB. J it's already boxed

  Children ← (6 2) (35 33 26 21) (7 7) 3 (19 14)
⍝ Children =: 6 2 ; 35 33 26 21 ; 7 7 ; 3 ; 19 14

⍝ P.70/92
''    ⍝ sqme in J
0⍴0   ⍝ 0$0 NB. J
⍝ i.0 NB. J   this does not work with ⍳ in APL
⊂⍬    ⍝ a:  NB. J primitive 'ace'
      ⍝ <'' NB. J

⍝ '' and 0⍴0 are not actually the same, but 0⍴0 and ⍬ are?

⍝ P.71/93
  Emptiness ← ⍬
  Presence ← 'Friendly'
  Emptiness ⍴ Presence
⍝ Emptiness =: ''
⍝ Presence =: 'Friendly'
⍝ Emptiness $ Presence`

⍝ P.81/103
  S ← 1
  V ← 1⍴S
  S = ⍬⍴V
⍝ S =: 1           NB. J
⍝ V =: 1$S         NB. J
⍝ S = ''$V         NB. J

  X ← '2 15 8 3'
⍝ X =: '2 15 8 3'  NB. J

  ⎕IO ← 0
  'LE CHAT'[6 4 1 2 3 5 6]
  (⊂6 4 1 2 3 5 6)⌷'LE CHAT'
⍝ 6 4 1 2 3 5 6 { 'LE CHAT'  NB. J
⍝ answer 'THE CAT'

  Tab ← 2 5 ⍴ 9 1 4 3 6 7 4 3 8 2
  Tab[Tab⍳9 6 7 2]←21 45 78 11
⍝ Tab =: 2 5 $ 9 1 4 3 6 7 4 3 8 2                                             NB. J
⍝ APLIndexOf =: [: ;/  ](]#~ [:*./"1 #@[>:])[:,"2&.|: i."1 ,"0~  [:i._2&{@$@[  NB. J
⍝ NB. This expression for APLIndex is unsatisfactory, generic fail
⍝ APLIndexOf =:  ] ([: ;/ ]#~ [:*./"1 #@[>:])  [:,"2&.|: 0 1 ,"0~ i."1         NB. J
⍝ NB. This expression for APLIndex is unsatisfactory, too specific
⍝ Tab =: 21 45 78 11 (Tab APLIndexOf 9 6 7 2) } Tab                            NB. J

  X ← 1 2 9 11 3 7 8
  X[2 4] ← X[3 0]
  X[2 4] ← (⊂3 0)⌷X
⍝ X =: 1 2 9 11 3 7 8    NB. J
⍝ X =: (3 0&{  2 4} ])X  NB. J


  Mystery[2 0 5 4 1 3]
  (⊂2 0 5 4 1 3)⌷Mystery
⍝ 2 0 5 4 1 3{Mystery  NB. J
8 11 3 9 2 15
  Mystery ← 11 2 8 15 9 3
⍝ Mystery =: 11 2 8 15 9 3 NB. J

⍝ P.82/104
  Vec ← 33 19 27 11 74 47 10 50 66 14
⍝ Vec =: 33 19 27 11 74 47 10 50 66 14  NB. J
  Vec[FindMe]
  FindMe⌷Vec
⍝ FindMe{Vec                        NB. J
47 27 19 14 50 74
FindMe ← 5 2 1 9 7 4
⍝ FindMe =: 5 2 1 9 7 5                 NB. J

  ⎕IO ← 0
  Source ← 10 4 13 3 9 0 7 6 2 13 8 1 5
⍝ Source =: 11 4 13 3 9 0 7 6 2 13 8 1 5  NB. J
  Set ← 3 3 ⍴ Source[1 3 7 4 11 12 6 3]
  Set ← 3 3 ⍴ (⊂1 3 7 4 11 12 6 3)⌷Source
⍝ Set =: 3 3 $ 1 3 7 4 11 12 6 3{Source  NB. J

  Result ← Source[Set]
  Result ← (⊂Set)⌷Source
⍝ Result =: Set { Source  NB. J
  ⍴ Result
  ⍝ $ Result  NB. J
3 3
  Result
 9 3 7
13 4 0
 6 3 9

  V1 ← 'p' 'o' 't'
  Vnest ← 'po' 't'
  V2 ← 'pot'
⍝ V1 =: 'p' 'o' 't'  NB. J syntax error
⍝ V1 =: 'p','o','t'  NB. J this will behave like APL V2
⍝ V3 =: 'po';'t'     NB. J "                       " Vnest
⍝ V2 =: 'pot'        NB. J
  V1 = V2
1
  Vnest
⍝ ┌2──────┐  ⍝ NARS2000 Box display
⍝ │┌2──┐  │
⍝ ││ po│ t│
⍝ │└───┘ ¯2
⍝ └∊──────┘
⍝ ┌──┬─┐  NB. J Box display
⍝ │po│t│
⍝ └──┴─┘

  V3 ← 15 48 'Y' 'e' 's' 52
  V4 ← 15 48 'Yes' 52
⍝ V3 =: 15; 48; 'Y'; 'e'; 's'; 54 NB. J
⍝ V4 =: 15; 48; 'Yes'; 54         NB. J
  ⍴V3 ⍝ $V3 NB. J
6
  ⍴V4 ⍝ $V4 NB. J
4

  Two ← 2 
  Foolish ← Two Two ⍴ 2 Two '⍴' 'Two'
⍝ Two =: 2 NB. J
⍝ Foolish =: (Two,Two) $ 2;Two;'⍴';'Two'  NB. J
⍝ or
⍝ Foolish =: s $ 2;Two;'⍴';'Two' [ s=: Two,Two NB. J
  ⍴Foolish ⍝ $Foolish  NB. J
2 2
⍝ ┌2───────────┐  ⍝ NARS2000 Box display
⍝ 2            │
⍝ │2     2     │
⍝ │~     ~     │
⍝ │            │
⍝ │      ┌3───┐│
⍝ │⍴     │ Two││
⍝ │¯     └────┘2
⍝ └∊───────────┘
⍝ ┌─┬───┐  NB. J Box display
⍝ │2│2  │
⍝ ├─┼───┤
⍝ │⍴│Two│
⍝ └─┴───┘

⍝ P.83/105

  0.413 = .413
1
  ¯0.5119 = ¯.5119
⍝ _0.5119 = _.5119  NB. J
1
⍝ 0.413 = .413  NB. J  The decimal point must be preceeded by 0 or _ in J
⍝ domain error     NB. J  Else it might be the space-dot verb

⍝ P.84/106

⍝ For exponents 'e' and 'E' are equivalent in both APL and J
⍝ However APL will default to 'E' and J to 'e' 
  4.27819E7
42781900
  4278.19E4
42781900
  384.21E¯8
⍝ 384.21E_8
0.0000038421
  3.8421E¯6
⍝ 3.8421E_6
0.0000038421

⍝ ⎕PP In J?


⍝ P.85/107
  Prod ← 5 2 12 ⍴ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37
⍝ Prod =: 5 2 12 $ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37 NB. J
  ⎕IO ← 0

  ∧/ 3 2 4 = ⍴Prod[1 4 2;1 0;0 1 4 5]
  ∧/ 3 2 4 = ⍴(1 4 2)(1 0)(0 1 4 5)⌷⍤(1 99)Prod
⍝   *./ 3 2 4 = $(<1 4 2;1 0;0 1 4 5){Prod
1

  ∧/ 5 6 = ⍴Prod[;1;⍳6]
  ∧/ 5 6 = ⍴(⍳0⊃⍴ Prod)(1)(⍳ 6)⌷⍤(1 99)Prod 
⍝ ∧/ 5 6 = ⍴(⊂⍬       )(1)(⍳ 6)⌷⍤(1 99)Prod  ⍝ doesn't work like J
⍝ *./5 6 = $(<a:       ;1; i.6){       Prod        NB. J   (a:) = (<'')
1

  Tests ← 6 3 ⍴ 41 26 38,14 87 52,30 28 19,65 40 55,19 31 64,45 82 74
⍝ Tests =: 6 3 $ 41 26 38,14 87 52,30 28 19,65 40 55,19 31 64,45 82 74 NB.J

  Tests[0 1 4 5;0]
  (0 1 4 5)0⌷⍤(1 99)Tests
⍝ (<0 1 4 5;0){Tests      NB. J
  Tests[0 1 4 5; ,0]
  (0 1 4 5)( ,0)⌷⍤(1 99)Tests
⍝ (<0 1 4 5; ,0){Tests    NB. J

⍝ P.86/108
  A ←  71 72 73 74 75 76
⍝ A =: 71 72 73 74 75 76  NB. J
  A[1 2 1 3 1]
  (⊂1 2 1 3 1)⌷A
⍝ 1 2 1 3 1{A             NB. J

  A[1 2 1 3 1]←45 19 67 33 50 ⋄ ⎕ ← A
⍝ ]A=: 45 19 67 33 50 (1 2 1 3 1)} A  NB. J


  Trix ← 3 8⍴0
⍝ Trix =: 3 8$0    NB. J
  nc ← 1↓⍴Trix
  New ← 3 nc ⍴0       ⍝ Domain Error (nc is a 1⍴8)
  New ← (3,nc)⍴0      ⍝ Domain Error (nc is a 1⍴8)
⍝ nc =: 1{.$Trix   NB. J
⍝ New =: (3,nc)$0  NB. J need "," syntax error before getting a domain error

⍝ P.87/109
  New ← (3,1↓⍴Trix)⍴0
⍝ New =: (3,1{.⍴Trix)⍴0  NB. J

⍝ P.90/112

⍝ Dyadic
⍝
⍝ APL| J
   + ⍝ +  Plus
   - ⍝ -  Minus
   × ⍝ *  Multiply
   ÷ ⍝ %  Divide
   ⍴ ⍝ $  Shape
   * ⍝ ^  Power
   ⌈ ⍝ >. Maximum
   ⌊ ⍝ <. Minimum
   > ⍝ >  GreaterThan
   ≥ ⍝ >: GreaterOrEqual
   < ⍝ <  LessThan
   ≤ ⍝ <: LessOrEqual
   = ⍝ =  Equal
   ≠ ⍝ ~: NotEqual
   | ⍝ |  Residue
   ∊ ⍝ e. Member

⍝ Monadic
⍝
⍝ APL| J
   + ⍝ +  Conjugate
   - ⍝ -  Negative
   × ⍝ *  Signum
   ÷ ⍝ %  Reciprocal
   ⍴ ⍝ $  SelfShape
   * ⍝ ^  NaturalExponential
   ⌈ ⍝ >. Ceiling
   ⌊ ⍝ <. Floor
   | ⍝ |  Magnitude
   ⊃ ⍝ >  (Disclose or Mix)/Unbox
     ⍝ >: Increment          (1∘+)
   ⊂ ⍝ <  Nest/Box
     ⍝ <: Decrement          (1∘-)
     ⍝ =  Self-Classify   prefered → APL: (⍳⍨)  J: (i.~)
   ≠ ⍝ ~: Nub Sieve

⍝ P.99/121
  MonMat ← 6 8 ⍴ 'January FebruaryMarch   April   May     June    ' 
⍝ MonMat =: 6 8 $ 'January FebruaryMarch   April   May     June    ' NB. J
'December' ∊ MonMat
⍝ 'December' ([: +./ e."1) MonMat  NB.J


  MonVec ← 'January' 'February' 'March' 'April' 'May' 'June' ⍝ nested
⍝ MonVec =: 'January';'February';'March';'April';'May';'June' NB. J  
  'December' ∊ MonMat ⍝ same result in APL
⍝ 'December' ([:+./ [e."1 [:> ]) MonVec  NB. J
  MonMat ∊ 'Century'
⍝ MonMat e.'Century'  NB. J

⍝ P.101/122
0 1 0 1 ∧ 0 0 1 1   ⍝   0 1 0 1 *. 0 0 1 1 NB. J
0 1 0 1 ∨ 0 0 1 1   ⍝   0 1 0 1 +. 0 0 1 1 NB. J
0 1 0 1 ≠ 0 0 1 1   ⍝   0 1 0 1 ~: 0 0 1 1 NB. J
~ 0 1 0 0 0 1 1     ⍝   -. 0 1 0 0 0 1 1   NB. J


  Forecast ← 4 6 ⍴ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350
  Actual   ← 4 6 ⍴ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363
⍝ Forecast =: 4 6 $ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350  NB. J
⍝ Actual   =: 4 6 $ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363  NB. J

  ⊢ bin ← Actual{(⍵>350) ∧ ⍺>⍵}Forecast
⍝ ] bin =: Actual{{ (y>350) *. x>y }}Forecast  NB .J
  ⊢ bin ← Actual(> ∧ 350<⊢)Forecast
⍝ ] bin =: Actual(> *. 350<] )Forecast         NB. J
 
⍝ P.102/123
  'This Winter is warm' ~ MonMat 
⍝ 'This Winter is warm' -. MonMat  NB. J
  'Congratulations' ~ 'ceremony' 
⍝ 'Congratulations' ~ 'ceremony'   NB. J 
  Magoo ← 2 3⍴ 26 16 22 17 21 44
⍝ Magoo =: 2 3$ 26 16 22 17 21 44  NB. J
  21 22 23 24 25 26 27 ~ Magoo
⍝ 21 22 23 24 25 26 27 -. Magoo    NB. J

  Children ← (6 2) (35 33 26 21) (7 7) 3 (19 14)
⍝ Children =: 6 2; 35 33 26 21; 7 7; 3; 19 14  NB. J

⍝ P.103/125
  Children+50
⍝ 50+&.>Children  NB. J

  What ← 19 (6 2) 3 (33 26)
⍝ What =: 19; 6 2; 3; 33 26  NB. J
  What ∊ Children
⍝ What e. Children  NB. J

  Children + 10 20 30 40 50
⍝ Children +&.> 10 20 30 40 50  NB. J
  Children + (4 8) (5 7 4 9) (1 ¯1) (100 200 500) (14 51)
⍝ Children +&.> 4 8; 5 7 4 9; 1 _1; 100 200 500; 14 51  NB. J
  Children+(1 2)(2 3)(3 4)(4 5)(5 6)
⍝ Children+&.>1 2; 2 3; 3 4; 4 5; 5 6  NB. J
LENGTH ERROR

⍝ P.107/129
  +/ (4 8) (1 4) 10 (9 5) 
⍝ +&.>/ 48; 1 4; 10; 9 5  NB. J


⍝ P.109/131
  Prod ← 5 2 12 ⍴ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37
⍝ Prod =: 5 2 12 $ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37 NB. J

  ⎕IO ← 0
  +/[0]   Prod     ⍝ this is affected by ⎕IO
  +⌿      Prod     ⍝  +⌿⍤(99)  rank 99 for "infinity"
⍝ +/    Prod     NB. J  "_ also works (_ is infinity)
  +/[1]   Prod
  +⌿⍤(¯1) Prod     ⍝ looks like APL ⌿ is equivalent to / in J
⍝ +/"_1 Prod     NB. J  "2 also works  

⍝ P.110/132
  +/[2]   Prod
  +⌿⍤(¯2)  Prod
⍝ +/"_2 Prod  NB. J  "1 also works

  Tam ← 3 5⍴ 2 3 5 8 8, 4 6 2 5 9, 1 4 9 7 8
⍝ Tam =: 3 5$ 2 3 5 8 8, 4 6 2 5 9, 1 4 9 7 8  NB. J
  Tam×[0]5 2 7 ⍝ the book has (5 2 10), but the result fits with 7
  Tam×⍤(1 0) 5 2 7
⍝ Tam*"(1 0) 5 2 7      NB. J
  Tam×[1]2 5 0 2 1
  Tam×⍤(¯1 99)2 5 0 2 1
⍝ Tam*"(_1 _)2 5 0 2 1  NB. J

⍝ P.111/133
⎕IO ← 0
t ← 2 5 5 ⍴⍳50
{≠/(⍴+/   ⍵) = ⍴ +⌿    ⍵}t
{=/(⍴+/[0]⍵) = ⍴ +⌿    ⍵}t
{=/(⍴+/   ⍵) = ⍴ +⌿[2] ⍵}t
{=/(⍴+/   ⍵) = ⍴ +⌿⍤(1)⍵}t
(≠/  +/      =⍥⍴ +⌿     )t
(=/  +/[0]   =⍥⍴ +⌿     )t
(=/  +/      =⍥⍴ +⌿[2]  )t
(=/  +/      =⍥⍴ +⌿⍤1   )t

⍝ P.114/136
⎕IO ← 0
  A ←  3 4⍴ 'A' ⋄ B ←  2 4⍴ 'B' ⋄ C ←  3 3⍴ 'C'
  (A B C) ←  (3 4 ⍴'A')  (2 4⍴ 'B')  (3 3⍴ 'C')
⍝ A =: 3 4$ 'A' [ B =: 2 4$ 'B' [ C =: 3 3$ 'C'
⍝ 'A B C' =: (3 4 $'A'); (2 4$ 'B'); (3 3$ 'C')

⍝ P.115/137
A,[0]B
A⍪B          ⍝ A,B         NB. J
A⍪⍤(99) B    ⍝ A,"(_) B    NB. J

B,[0]A
B⍪A          ⍝ B,A         NB. J

A,[1]C
A⍪⍤ ¯1 C     ⍝ A,"_1 C     NB. J

C,[1]A
C⍪⍤ ¯1 A     ⍝ C,"_1 A     NB. J

A,[0] 'JUMP'
A⍪ 'JUMP'    ⍝ A,'JUMP'    NB. J

A,[1]
A⍪⍤ ¯1 'TOP' ⍝ A,"_1 'TOP' NB. J

⍝ P.116/138
⎕IO ← 0
  Forecast ←  4 6 ⍴ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350
⍝ Forecast =: 4 6 $ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350  NB. J

  Forecast,[0] (+/[0] Forecast)
  (⊢ ⍪ +⌿) Forecast
⍝ (] , +/) Forecast  NB. J
⍝ (  , +/) Forecast  NB. J   as a hook

  A ←  3 4 6⍴'A' ⋄ B ← 3 6⍴ 'B'
⍝ A =: 3 4 5$'A' [ B =: 3 6$ 'B'  NB. J

  A,[1]B
  A⍪⍤¯1 B
⍝ A,"_1 B  NB. J

  Subcon ←  5   12⍴  0 0 0 0 0 0 5 6 6 6 6 7, 7 7 8 10 10 10 10 8 7 8 10, 10 10 12 11 12 10 11 9 6 6 6 8, 8 9 14 15 18 19 20 19 20 17 15 14, 14 15 18 18 13 12 10 10 11 11 11 11
  Prod   ←  5 2 12⍴ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37
⍝ Subcon =: 5   12$  0 0 0 0 0 0 5 6 6 6 6 7, 7 7 8 10 10 10 10 8 7 8 10, 10 10 12 11 12 10 11 9 6 6 6 8, 8 9 14 15 18 19 20 19 20 17 15 14, 14 15 18 18 13 12 10 10 11 11 11 11  NB.J
⍝ Prod   =: 5 2 12$ 26 16 22 17 21 44 25 22 23 44 41 33,43 36 47 49 30 22 57 20 45 60 43 22,44 21 58 57 17 43 47 17 43 26 53 23,29 19 23 38 53 47 38 22 40 57 35 26,37 27 53 26 29 46 25 26 30 20 32 16,56 55 25 47 38 27 39 59 20 28 42 25,21 57 55 44 16 54 26 16 55 56 45 45,16 55 26 20 27 55 36 39 43 38 50 16,27 23 56 41 53 60 39 47 44 47 17 28,24 35 61 26 22 35 24 20 31 35 47 37 NB. J

⍝ P.117/139
  Prod,[1] Subcon
  Prod ⍪⍤¯1 Subcon
⍝ Prod ,"_1 Subcon  NB. J

  A ← 3 4⍴ 'A'
⍝ A=: 3 4$ 'A'      NB. J
  A,[0] '-'
  A⍪ '-'
⍝ A, '-'            NB.J

  A,[1] '*'
  A⍪ '*'
⍝ A, '*'            NB.J

⍝ P.118/140
⎕IO ← 0
  Contents ← 12 56 78 74 85 96 30 22 44 66 82 27
⍝ Contents =: 12 56 78 74 85 96 30 22 44 66 82 27  NB.J

  Contents[5 6 11]
  (⊂4 5 10)⌷Contents
⍝ 4 5 10{ Contents NB. J

  0 1 1 0 ⌿ 42 15 79 66
⍝ 0 1 1 0 # 42 15 79 66  NB. J

  1 0 1 0 0 0 0 1 1 ⌿ 'Drumstick'
⍝ 1 0 1 0 0 0 0 1 1 # 'Drumstick'  NB. J

  {  (⍵>80) ⌿   ⍵}  Contents
  (   >∘80 (⌿⍤1)⊢)  Contents
⍝ {{ (y>80) #   y }}Contents  NB. J
⍝ (   >&80  #   ])  Contents

  Chemistry ← 3 5⍴ 'H2SO4', 'CaCO3', 'Fe203'
⍝ Chemistry =: 3 5$ 'H2SO4', 'CaCO3', 'Fe203'  NB. J

⍝ P.119/141
⎕IO ← 0
  1 0 1 /[0] Chemistry
  1 0 1 ⌿    Chemistry         ⍝      1 0 1 ⌿⍤(99) Chemistry
⍝ 1 0 1 #    Chemistry         NB. J  1 0 1 #"(_) Chemistry
  1 1 0 1 0 /[1]    Chemistry
  1 1 0 1 0 ⌿⍤(1 ¯1)Chemistry  ⍝      1 1 0 1 0 ⌿⍤(1) Chemistry
⍝ 1 1 0 1 0 #"(1 _1)Chemistry  NB. J  1 1 0 1 0 #"(1) Chemistry  

  bin ← Contents<50
⍝ bin =: Contents<50  NB. J
  +/ bin ⍝ its a vector so it's the same in J
  bin / Contents 
  ⍝ bin # Contents    NB. J

  ix ←  bin /⍳ ⍴ Contents 
⍝ ix =: bin #i.$ Contents          NB. J
  ix ←  bin  ((⌿⍤1)∘⍳∘⍴  )Contents
⍝ ix =: bin  ([#   i.@$@])Contents  NB. J
  Contents[ix]
  Contents⌷⍨⊂ix
⍝ ix{Contents   NB. J

  bin { ⍵⌷⍨⊂  ⍺⌿    ⍳ ⍴ ⍵ }Contents
⍝ bin {{y{~   x#    i.$ y}}Contents  NB. J
  bin ( ⊢⌷⍨∘⊂ (⌿⍤1)∘⍳∘⍴   )Contents
⍝ bin ( ]{~   [#  [:i.$@] )Contents  NB. J

⍝ P.120/142
0 1 3 0  ⌿ 42 15 79 66  ⍝ 0 1 3 0  # 42 15 79 66 NB. J
0 1 3 0  ⌿ 'boat'       ⍝ 0 1 3 0  # 'boat'      NB. J
2 ¯3 1 0 ⌿ 42 15 79 66  ⍝ 2 ¯3 1 0 # 42 15 79 66
2 ¯3 1 0 ⌿ 'boat'       ⍝ 2 ¯3 1 0 # 'boat'

  v ←  'Phew'
⍝ v =: 'Phew'
  1 3 0 ⌿⍤(0 1)v
⍝ 1 3 0 #"(0 1)v

⍝ P.121/143
⎕IO ← 0
  Vec ←  15 42 53 19 46 53 82 17 14 53 24
⍝ Vec =: 15 42 53 19 46 53 82 17 14 53 24 NB. J
  Vec ⍳  19 14 53 49 15
⍝ Vec i. 19 14 53 49 15                   NB. J

'ABC' ⍳ 57  ⍝  'ABC' i. 57 NB. J
4 8 ⍳ '4 8' ⍝  4 8 i. '4 8'

  Alpha ←  'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'
⍝ Alpha =: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'
  Alpha ⍳ Chemistry 
⍝ Alpha i. Chemistry

  'Tee' (3 7) 'Golf' ⍳ 3 7 (3 7) 'Tee' 'Green'
⍝ ('Tee';(3 7);'Golf') i. 3;7;(3 7);'Tee';'Green'

⍝ P.123/145
⎕IO ← 0
  D ← 84
  Area ← 17 50 59 84 89
  Discount ← 9 8 6 5 4 2
⍝ D =: 84
⍝ Area =: 17 50 59 84 89   NB. J
⍝ Discount =: 9 8 6 5 4 2  NB. J
  Area ⍳  D 
⍝ Area i. D                NB. J
  Discount[3]
  3 ⌷ Discount
⍝ 3 { Discount             NB. J

⍝ P.124/146
  D ←  24 75 89 60 92 50 51 50 84 66 17 89
⍝ D =: 24 75 89 60 92 50 51 50 84 66 17 89 NB. J
  Discount[Area ⍳ D]
  (⊂Area ⍳ D)⌷Discount
⍝ Discount{~Area i. D NB. J
  AlphLower ←  'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  AlphUpper ←  'ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ*'
  Tale      ←  'Le Petit Chaperon-Rouge a bouffé le Loup'
⍝ AlphLower =: 'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ'   NB. J
⍝ AlphUpper =: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ*'  NB. J
⍝ Tale      =: 'Le Petit Chaperon-Rouge a bouffé le Loup'                     NB. J
   AlphaUpper[AlphaLower ⍳ Tale]
  (AlphaLower ⍳  Tale)⌷⍤(0 99)AlphaUpper
⍝ (AlphaLower i. Tale){       AplphaUpper  NB. J DOMAIN ERROR

⍝ P.125/147
⎕IO ← 0
  Vec ← 15 42 53 19 46 53 82 17 14 53 24
⍝ Vec =: 15 42 53 19 46 53 82 17 14 53 24 NB. J

  Vec[⍳11]
  (⊂⍳11)⌷Vec
⍝ (i.11){Vec

  OrgStpLth ←  115 7 6
⍝ OrgStpLth =: 115 7 6                      NB. J
  ArthSeries ←  { (0⌷⍵)+(1⌷⍵)×    ⍳2⌷⍵}
  ArthSeries ←  {(a b c)←⍵ ⋄ a+b×⍳c}
⍝ ArthSeries =: {{(0{y)+(1{y)*    i.2{y             }}  NB. J
⍝ ArthSeries =: {{    a+    b*    i.c    ['a b c'=.y}}  NB. J

  ArthSeries ←  (   0∘⌷+  1∘⌷×    ⍳∘(2∘⌷            ))
⍝ ArthSeries =:     0&{+  1&{*  [:i. 2&{                NB. J
⍝ ArthSeries =:      {.+  1&{*  [:i. {:                 NB. J  "head" "second" "tail"

ArthSeries OrgStpLth

  ⍬≡⍳0
⍝ ($0)-:i.0  NB. J

⍝ P.126/148
⎕IO ← 0
  Vec ← 41 17 19 53 42 27 19 88 14 56 19 33
⍝ Vec =: 41 17 19 53 42 27 19 88 14 56 19 33  NB. J

  findIndex ←  { (⍺=⍵)⌿      ⍳ ≢  ⍵ }
⍝ findIndex =: {{(x=y)#      i.#  y}}         NB. J
  findIndex ←  (   = (⌿⍤1) ⊢∘⍳∘≢    )
⍝ findIndex =:     =  #    [:i.#@:]           NB. J

19 findIndex Vec

  Phrase ← 'Panama is a canal between Atlantic and Pacific'
⍝ Phrase =: 'Panama is a canal between Atlantic and Pacific'  NB. J
'a' findIndex Phrase

  'aeiouy' (⊣⍪⍤0 (⊂  findIndex)⍤(0 1)) Phrase
⍝ 'aeiouy' ([;"0  <@:findIndex" (0 1)) Phrase   NB. J

  myMember ← (( (⊂⍋)⌷⊢)∘∪∘,  findIndex⍤(0 1) )
⍝ myMember =: [:( /:{])@~.@, findIndex"(0 1)  NB. J
'aeiouy' myMember Phrase

⍝ P.127/149
  memIndex ← {  (⍵∊⍺)  ⌿      ⍳ ≢ ⍵}
⍝ memIndex =: {{(y e.x)#      i.# y}}       NB. J
  memIndex ← (     ∊⍨ (⌿⍤1) ⊢∘⍳∘≢   )
⍝ memIndex =:      e.~ #     i.@#@]         NB. J

⍝ NARS2000
  Countries ← ⍪∘⊃'France' 'Great Britain' 'Italy' 'United States' 'Belgium' 'Swiss' 'Sweden' 'Canada' 'Egypt' 'Brazil'
⍝ Dyalog
  Countries ← ⍪⍤↑'France' 'Great Britain' 'Italy' 'United States' 'Belgium' 'Swiss' 'Sweden' 'Canada' 'Egypt' 'Brazil'
⍝ Countries =: ,.@:>'France';'Great Britain';'Italy';'United States';'Belgium';'Swiss';'Sweden';'Canada';'Egypt';'Brazil' NB. J
  Codes ← 50 43 12 83 64 34 66 81 37 14
⍝ Codes =: 50 43 12 83 64 34 66 81 37 14          NB. J

⍝ P.128/150
  BHCodes ← 83 12 12 83 43 66 50 81 12 83 14 66
⍝ BHCodes =: 83 12 12 83 43 66 50 81 12 83 14 66                NB. J
  BHAmounts ← 609 727 458 469 463 219 431 602 519 317 663 631
⍝ BHAmounts =: 609 727 458 469 463 219 431 602 519 317 663 631  NB. J
  Selected ← 14 43 50 37 66
⍝ Selected =: 14 43 50 37 66                                    NB. J

  BHCodes ∊ Selected ⍝ BHCodes e. Selected             NB. J
⍝ there are missing numbers so the answer will be incomplete compared to the book

  BH ← BHCodes BHAmounts
⍝ BH =: BHCodes ,: BHAmounts
  Selected {  +⌿(⍺ ∊⍨ 0⊃⍵)/1⊃⍵  } BH
⍝ Selected {{ +/(x e.~0{y)#1{y }} BH                   NB. J
  Selected (  +⌿⍤1 ((1 ⊃ ⊢) (⌿⍤1⍨) ⊣∊⍨  0⊃⊢)) BH
⍝ Selected ([:+/     1&{@]   #~    [e.~ 0{] ) BH       NB. J

  Positions ←  Selected{ (⍵ ∊ ⍺)/      ⍳ ≢⍵ }BHCodes
⍝ Positions =: Selected{{(y e.x)#      i.#y}}BHCodes   NB. J
  Positions ←  Selected(    ∊⍨ (⌿⍤1) ⊢∘⍳∘≢  )BHCodes
⍝ Positions =: Selected(    e.~ #    [:i.@#])BHCodes   NB. J
  BHAmounts{  +⌿ ⍺[⍵]   }Positions
  BHAmounts{  +⌿(⊂⍵)⌷⍺  }Positions
⍝ BHAmounts{{ +/  y {x }}Positions                     NB. J
  BHAmounts(  +⌿ ⌷⍨∘⊂)Positions
⍝ BHAmounts([:+/ {~  )Positions                        NB. J

⍝ P.129/151
⎕IO ← 0
⍝ NARS2000
  Countries ←    ⍪∘⊃'France' 'Great Britain' 'Italy' 'United States' 'Belgium' 'Swiss' 'Sweden' 'Canada' 'Egypt' 'Brazil'
⍝ Dyalog ⍝ this should be changable with a ⎕ something
  Countries ←    ⍪⍤↑'France' 'Great Britain' 'Italy' 'United States' 'Belgium' 'Swiss' 'Sweden' 'Canada' 'Egypt' 'Brazil'
⍝ Countries =: ,.@:>'France';'Great Britain';'Italy';'United States';'Belgium';'Swiss';'Sweden';'Canada';'Egypt';'Brazil' NB. J
  Codes ←  50 43 12 83 64 34 66 81 37 14
⍝ Codes =: 50 43 12 83 64 34 66 81 37 14                             NB. J
  Selected ←  14 43 50 37 66
⍝ Selected =: 14 43 50 37 66                                         NB. J

  Selected,[1]   ⍨Countries[  Codes ⍳ Selected;]  ⍝  This appended the number as a character litteral
  Selected,      ⍨Countries⌷⍨⊂Codes ⍳ Selected
  Selected⍪⍤(1 0)⍨Countries⌷⍨⊂Codes ⍳ Selected
⍝ (' '(,"1) ":"0 Selected)        ,"1~ Countries{~Codes i. Selected  NB. J
⍝ Selected(] (,"1) ' '&(,"1)@(":"0)@[) Countries{~Codes i. Selected  NB. J

⍝ Inverted Table to keep values separate but still display nicely
  CC ←  Countries ⍪⍥⊂⍪Codes
⍝ CC =: Countries ; ,.Codes                                          NB. J

  Selected{ (⍪ ⍺) ⍪⍥⊂⍨  (⊃ 0⌷⍵)⌷⍨⊂    ⍺⍳⍨     ,⊃    1⌷⍵  }CC
⍝ Selected{{(,.x),&:<~  (> 0{y){~     xi.~    ,>    1{y }}CC         NB. J
  Selected(⊣⍥⍪   ⍪⍥⊂⍨   (⊃(0⌷⊢))⌷⍨∘⊂  ⊣⍳⍨    (,∘⊃  (1⌷⊢)))CC
⍝ Selected(,.@:[ ,&:<~  (0>@{]){~     [i.~  [:,@:>  1{]  )CC         NB. J

⍝ P.131/153
  Vec ←  12 89 57 46 12 50 36 37 83 46 27 12
⍝ Vec =: 12 89 57 46 12 50 36 37 83 46 27 12  NB. J

  ⍳⍴Vec               
⍝ i.$Vec                     NB. J
  Vec ⍳ Vec
⍝ Vec i.Vec                  NB. J

  {( ⍳ ⍴⍵)=⍳⍨ ⍵ }Vec
⍝ {{(i.$y)=i.~y}}Vec         NB. J
  (  ⍳∘⍴  =⍳⍨   )Vec
⍝ (  i.@$ =i.~  )Vec         NB. J

  { ⍵ /⍨   (⍳ ⍴⍵)=⍳⍨ ⍵ }Vec
⍝ {{y #~   (i.$y)=i.~y}}Vec  NB. J
  ( ⊢(⌿⍤1)⍨ ⍳∘⍴  =⍳⍨   )Vec
⍝ ( ] #~    i.@$ =i.~  )Vec  NB. J

Text ← 'All men are created equal'
⍝ Text =: 'All men are created equal'
  { ⍵/⍨     (⍳⍴ ⍵)=⍳⍨ ⍵ }Text
⍝ {{y#~     (i.$y)=i.~y}}Text                 NB. J
  ( ⊢(⌿⍤1)⍨  ⍳∘⍴  =⍳⍨   )Text
⍝ ( ]#~      i.@$ =i.~  )Text                 NB. J

⍝ P.132/154
∪ Vec  ⍝ ~.Vec                                NB. J

6000×1.04*⍳6
⍝ 6000*1.04^i.6                               NB. J

⍝ P.133/155
  Tests ←  6 3 ⍴ 11 26 22, 14 87 52, 30 28 19, 65 40 55, 19 31 64, 33 70 44
⍝ Tests =: 6 3 $ 11 26 22, 14 87 52, 30 28 19, 65 40 55, 19 31 64, 33 70 44
  Chemistry ←  3 5⍴ 'H2SO4', 'CaCO3', 'Fe203'
⍝ Chemistry =: 3 5$ 'H2SO4', 'CaCO3', 'Fe203'  NB. J
  Forecast ←  4 6 ⍴ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350
⍝ Forecast =: 4 6 $ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350  NB. J

,Tests ⍝ same in J
,Chemistry

⎕IO ← 0
  Cols ←  0 3 5
⍝ Cols =: 0 3 5
  Forecast[;Cols]
  Forecast⌷⍨⍤(¯1 1)⊂Cols
⍝ Forecast{~ <a: ;Cols

  Forecast[;,3]
  Forecast⌷⍨⍤(¯1 1)⊂,3
⍝ Forecast{~ <a: ;,3

⍝ P.134/156
Hole ← ⍬    ⍝ Hole=: ''   NB. J
Hole + 3
Hole × 100  ⍝ Hole * 100  NB. J
Hole = 0
Hole = Hole
⍴Hole       ⍝ $Hole

⍝ P.136/158
⎕IO ← 0
⍝ C-1
  3×2+6≠ 3×2
⍝ 3*2+6~:3*2            NB. J
6
  12 6 27⌊ 12+⍳3
⍝ 12 6 27<.12+⍳3        NB. J
12 6 14
    4 5 6⌈ 4+2 5 9>1 6 8
⍝ 4 5 6>.4+2 5 9>1 6 8  NB. J
5 5 6
  7⌊ 25 6 17-9 3 5+2×3
⍝ 7<.25 6 17-9 3 5+2*3  NB. J
7 ¯3 6        ⍝ 7 _3 6  NB. J
  ((8+6)×2+1)×3-6÷3
⍝ ((8+6)*2+1)*3-6%3     NB. J
42
  (⍴4⌈ 5)+4⌈5
⍝ 4($+])@:<.5           NB. J

⍝ it's Blank

⍝ C-2
4 4
6 6
4 6
2 4 4

⍝ C-3
  A ← 8 2 7 5
⍝ A =: 8 2 7 5 NB. J
⎕IO ← 0
5 and 4
1 2 3 4 and 0 1 2 and 0 1 2 3

⍝ C-4
  3⌈ ¯1+⍳ 4
⍝ 3>._1+i.4    NB. J

⍝ P.137/159
⍝ C-5
  Scalar ← 5
⍝ Scalar =: 5
  {  ~ ⍬ ≢ ⍴⍵ }Scalar  
⍝ {{ ~:''-:$y}}Scalar  NB. J
  (  ~ ⍬ ≢ ⍴  )Scalar  
⍝ ([:~:''-:$  )Scalar  NB. J

⍝ C-6
⎕IO ← 0
  A(3 7⌷⍨≥)B
⍝ A(3 7{~>:)B               NB. J

⍝ C-7
  A{ (0 ≠  ⍵)×  3×  1⍴⍨  0≠ ⍺ }B
⍝ A{{(0 ~: y)*  3*  1$~  0~:x}}B  NB. J
  A( (0 ≠  ⊢)×  3×  1⍴⍨  0≠ ⊣ )B
⍝ A(  0&~:@] *  3*  1$~  0~:[ )B    NB. J

⍝ C-8
  0 0 1 1 × 0 1 0 1
⍝ 0 0 1 1 * 0 1 0 1         NB. J

⍝ C-9
  G ←  1 1 1 0 0 1 ⋄ M ←  0 0 1 1 0 1 ⋄ D ←  1 0 1 0 1 0
⍝ G =: 1 1 1 0 0 1 [ M =: 0 0 1 1 0 1 [ D =: 1 0 1 0 1 0  NB. J
1 1 1 0 1 1 ⍝ a
0 1 0 1 1 1 ⍝ b
0 0 0 0 1 0 ⍝ c
0 0 0 0 1 0 ⍝ d

1 0 1 0 0 1 ⍝ e
0 0 0 1 0 0 ⍝ f
0 0 1 0 1 0 ⍝ g
1 0 0 1 1 0 ⍝ h

⍝ C-10
⎕IO ← 0

1          ⍝ a
1 0 0 1 0  ⍝ b
1 1        ⍝ c
1 0        ⍝ d

⍝ C-11
  Tex ← 'The silence of the sea'
⍝ Tex =: 'The silence of the sea'  NB. J

  'e'{  +⌿⍺=⍵ }Tex
⍝ 'e'{{ +/x=y}}Tex                NB. J
  'e'(  +⌿ =  )Tex
⍝ 'e'([:+/ =  )Tex                NB. J
5

⍝ P.138/160
⍝ C-12
⍝ using more parens for clarity
  C12 ←  {  (1 7 ≡ 2⍴⍵ )∧ (20 =   +⌿⍵)∧ (( ⍪0 0 1 0)  ≡ 9 =⍵)  }
⍝ C12 =: {{ (1 7-: 2$,y)*.(20 =   +/y)*.((,.0 0 1 0) -: 9 =y) }}  NB. J
  C12 ←  (  (1 7∘≡ 2∘⍴ )∧  20∘=∘( +⌿ )∧ (( ⍪0 0 1 0)  ≡ 9∘= )  )
⍝ C12 =:    (1 7-: 2$, )*. 20&=@:(+/ )*.((,.0 0 1 0) -: 9&= )     NB. J 
  Z ←  4 1 ⍴ 1 7 9 3
⍝ Z =: 4 1 $ 1 7 9 3                                          NB. J
⍝ notice that ⍴ is $, in J. in J it affects the leading axis
C12 Z

⍝ C-13
⎕IO ← 0
⍝ using more parens for clarity
  C13 ←  { (8 7 6 5≡ +/[0]⍵)∧  (20 6≡   +/[1]  ⍵)∧  ((0 1 0 0,[¯.5]1 0 0 1)≡ 0=⍵) }
  C13 ←  { (8 7 6 5≡ +⌿   ⍵)∧  (20 6≡   +⌿⍤¯1  ⍵)∧  ((0 1 0 0,[¯.5]1 0 0 1)≡ 0=⍵) }
⍝ C13 =: {{(8 7 6 5-:+/   y)*. (20 6-:  +/"_1  y)*. ((0 1 0 0,:    1 0 0 1)-:0=y)}}  NB. J
  C13 ←  ( (8 7 6 5∘≡∘(+⌿) )∧  (20 6∘≡∘(+⌿⍤¯1)  )∧  ((0 1 0 0,[¯.5]1 0 0 1)≡ 0=⊢) )
⍝ C13 =:   (8 7 6 5&-:@:+/ )*. (20 6&-:@:(+/"_1))*. ((0 1 0 0,:    1 0 0 1)-:0=])    NB. J
  Z ←  2 4 ⍴ 8 0 7 5, 0 7 ¯1 0
⍝ Z =: 2 4 $ 8 0 7 5, 0 7 _1 0     NB. J
C13 Z

⍝ C-14
  Tex ← 'The silence of the sea'
⍝ Tex =: 'The silence of the sea'  NB. J
  'e'(∊ ⍨(⌿⍤1)  ⊢∘⍳∘⍴  )Tex
⍝ 'e'(e.~ #   [: i.@$ ])Tex        NB. J

⍝ C-15
  { ⍵ ⌿⍨   0 1⍴⍨≢⍵ } Vec
⍝ {{y #~   0 1$~#y}} Vec         NB. J
  ( ⊢(⌿⍤1)⍨0 1⍴⍨≢  ) Vec
⍝ ( ] #~   0 1$~#  ) Vec         NB. J

⍝ C-16
  ≢,Prod
⍝ #,Prod  NB. J
120

⍝ C-17
  ⎕IO ← 0
  { (⍵ ∊   20+⍳ 10)  ⌿   ⍵ }Vec
⍝ {{(y e.  20+i.10)  #   y}}Vec  NB. J
  (    ∊∘( 20+⍳ 10) (⌿⍤1)⊢ )Vec
⍝ (    e.&(20+i.10)  #   ] )Vec  NB. J

⍝ C-18
  { ⍵ {⍵+ ⍺×    ~×⍵ } (30(⊣×<)⍵) + 20 (⊣×>)⍵ } Vec
⍝ {{y{{y+ x*   -.*y}} (30([*<)y) + 20 ([*>)y}} Vec  NB. J
  ( ⊢ (⊢+ ⊣× {⍺⊢~×⍵})  30∘(⊣×<)  + 20∘(⊣×>  )) Vec
  ( ⊢ (⊢+ ⊣×  ⊢∘~∘× )  30∘(⊣×<)  + 20∘(⊣×>  )) Vec
⍝ ( ] (]+ [* -.@*@] )  30&([*<)  + 20&([*>  )) Vec  NB. J

⍝ C-19
⍝ a) Syntax Error: missing parren
⍝ b) Works in J and Nars2000 has infinities, in Dyalog Domain Error; div by Zero error
⍝ c) Syntax Error ¯X (high minus variable), possible Value error too
⍝ d) Length Error (4 5 6 is length 3; 2 3-1 is length 2)
⍝ e) Domain Error negative input for ⍳

⍝ P.139/161

⍝ C-20
  ⎕IO ← 0
  23+11×⍳ 17
⍝ 23+11*i.17 NB. J

⍝ C-21
  PCodes  ←  56 66 19 37 44 20 18 23 68 70 82
  Prices  ←  9  27 10 15 12 5  8  9  98 7  22
  Wanabuy ←  37 1  70 20 19 2  82 5  23 10
⍝ PCodes  =: 56 66 19 37 44 20 18 23 68 70 82  NB. J
⍝ Prices  =: 9  27 10 15 12 5  8  9  98 7  22  NB. J
⍝ Wanabuy =: 37 1  70 20 19 2  82 5  23 10     NB. J

⍝ Place codes above price/quantity
  PC_P ←  PCodes ⍪[¯.5] Prices
⍝ PCodes_Prices =: PCodes ,:     Prices        NB. J

  Wb ←  {  ⍉     (2,⍨1r2× ≢⍵)⍴⍵ }Wanabuy
⍝ Wb =: {{ |:    (2,~1r2* #y)$y}}Wanabuy      NB. J
  Wb ←  (  ⍉  ⊢⍴⍨ 2,⍨1r2× ≢     )Wanabuy
⍝ Wb =: ([:|: ]$~ 2,~1r2* #     )Wanabuy      NB. J

  PC_P{  +⌿ (1⌷⍵)× (1⌷⍺)⌷⍨ ⊂ ,(0⌷⍺){ (⍺=⍵)⌿     ⍳ ≢ ⍺ }⍤(1 0)(0⌷⍵) }Wb
⍝ PC_P{{ +/ (1{y)* (1{x){~   ,(0{x){{(x=y)#    i. # x}}"(1 0)(0{y)}}Wb  NB. J
  PC_P(  +⌿((1⌷⊢)× (1⌷⊣)⌷⍨∘⊂∘,(0⌷⊣)(   = (⌿⍤1) (⍳∘≢ ⊣))⍤(1 0)(0⌷⊢)))Wb
⍝ PC_P([:+/ (1{])* (1{[){~ [:,(0{[)(   =  #    i.@#@[ )"(1 0)(0{]) )Wb  NB. J

⍝ C-22
⍝ a)
  notSold ←  Tickets{ (~ ⍺ ∊ ⍵) ⌿   ⍺ }Sold
⍝ notSold =: Tickets{{(-.x e.y) #   x}}Sold  NB. J
  notSold ←  Tickets( (~   ∊  )(⌿⍤1)⊣ )Sold
⍝ notSold =: Tickets(  -.@e.    #   [ )Sold  NB. J

⍝ b)
  notSold{ 0≠   +⌿ ⍺ ∊ ⍵ }Winners
⍝ notSold{{0~:  +/ x e.y}}Winners            NB. J
  notSold( 0≠  (+⌿   ∊  ))Winners
⍝ notSold( 0~: [:+/  e.  )Winners            NB. J

⍝ c)
  Ours{  +⌿⍺ ∊ ⍵ }Winners
⍝ Ours{{ +/x e.y}}Winners                     NB. J
  Ours(  +⌿  ∊   )Winners
⍝ Ours([:+/  e.  )Winners                     NB. J

⍝ d)
  WP ←  Winners ⍪[¯.5] Prizes
⍝ WP =: Winners ,:     Prizes                  NB. J

  WP{  +⌿ (1⌷⍺)⌷⍨⊂  , (0⌷⍺){(⍺=⍵)⌿    ⍳  ≢ ⍺ }⍤(1 0)⍵ }Ours
⍝ WP{{ +/ (1{x){~   , (0{x)(  =  #    i.@#@[ )"(1 0)y}}Ours      NB. J
  WP(  +⌿((1⌷⊣)⌷⍨∘⊂∘, (0⌷⊣)(  = (⌿⍤1)(⍳∘≢  ⊣))⍤(1 0)⊢))Ours
⍝ WP([:+/ (1{[){~ [:, (0{[)(  =  #    i.@#@[ )"(1 0)] )Ours      NB. J

⍝ C-23
  ⎕IO ← 0
  {  ⍵ ⌿   1+ ⍳  ≢⍵ }{   (⌈ ⍵)=⌊ ⍵ }{   ⍵÷ 1↓    ⍳ ⌊   1r2×⍵ }N
⍝ {{ y #   1+ i. #y }}{{ (>.y)=<.y }}{{ y% 1}.   i.<.  1r2*y}}N  NB. J
  (  ⊢(⌿⍤1)1+ ⍳∘≢   )∘(   ⌈   =⌊   )∘(  ⊢÷ 1↓  ( ⍳∘⌊   1r2×⊢))N
⍝ (  ] #   1+ i.@#  )@:(  >.  =<.  )@:( ]% 1}. [:i.@<. 1r2*] )N  NB. J

⍝ P.140/162
  Before ←  20 31 0 120 63
  After  ←  22 27 0 149 59
⍝ Before =: 20 31 0 120 63               NB. J
⍝ After  =: 22 27 0 149 59               NB. J

  Before{  ⌊  0.5+ 100× ⍺÷⍨ ⍵-⍺ }After
⍝ Before{{ <. 0.5+ 100* x%~ y-x}}After  NB. J
  Before(  ⌊ (0.5+ 100× ⊣÷⍨  -⍨))After
⍝ Before([:<. 0.5+ 100* [%~  -~ )After  NB. J
  ⎕DIV ← 0       ⍝ Identical to NARS2000 answer
10 ¯13 100 24 ¯6
  ⎕DIV ← 1       ⍝ ⎕DIV as a system variable is a Dyalog feature not in NARS2000 or J
10 ¯13   0 24 ¯6 ⍝ Identical to J

⍝ p.141/163
  ⍱      ⍝      NOR
  ⍲      ⍝      NAND
⍝ +:     NB. J  NOR
⍝ *:     NB. J  NAND

⍝ P.142/164
  shape ←  2 3  ⍝ note shape is a vector
⍝ shape =: 2 3  NB. J
  ⍳  shape
⍝ i. shape      NB. J this is not the same result

⍝ Argument must be a shape;the ⍳ is justified in the following as shape
⍝ must be a vector, which has the same behavior in J
  APL_iota ←  { ⍵⍴   ⊂⍤1  ⍵⊤⍤(1 0)   ⍳ ×⌿⍵  }
⍝ APL_iota =: {{y$   <"1  y#:        i.*/y }}
  APL_iota ←  ( ⊢⍴ ( ⊂⍤1  ⊢⊤⍤(1 0) ( ⍳ ×⌿ ))) 
⍝ APL_iota =: ( ]$ [:<"1  ]#:      [:i.*/   )

⍝ P.143/165
  Data[⍳⍴Data]         ⍝ is there a way to do it with ⌷ ?
⍝ Data{~APL_iota$Data  NB. J

⍝ R ←,[Axis] Data
⍝                                        "top ranks"  "bottom rank"
  ,[⍬] Data  ⍝    note       Data  ≡ ( (,¯1↓⍴ Data) , (,¯1↑⍴Data)  )⍴,Data
              ⍝         (,[⍬] Data) ≡ ( (,¯1↓⍴ Data) , (,¯1↑⍴Data), 1)⍴,Data
              ⍝                                 (notice this 1 here ↑)
  ,⍤0⊢ Data  ⍝     the ⊢ can explicitly keep the rank value separate from the argument
  ⍪⍤1⊢ Data  ⍝    !! careful ⍪ isn't the same as J's , !!
⍝ ,"0] Data  NB.J 

⍝ P.144/166

  ,[.5] Data
⍝ ,:"_1 Data

⍝ APL rank version?
⍝ TODO :: refactor
⍝
⍝ ¯∞=>same as zero
⍝ 0 =>shape 1
⍝ ¯1=>(  1 ↓shape), 1, ((rank-1)↓shape)
⍝ 1 =>( ¯1 ↓shape), 1, 1
⍝ n =>((-n)↓shape), 1, ((rank-n)↓shape)
⍝ ∞ =>              1,           shape
⍝
⍝ first change argument to matchedN
⍝ match (n≥0) {0 =>{if ((-n)≥rank){0   }else{rank+n}},      ⍝ ¯∞..¯1  case
⍝              1 =>{if (  n ≥rank){rank}else{n     }},}     ⍝  0..∞   case
⍝
⍝ new shape ←  matchedN((-⊣)(↓ ,  1,  (⊣+  ⊢∘≢)↓  ⊢) (⍴⊢))Data
⍝ new shape =: matchedN( -@[(}.,  1,  ([+  #@])}. ])  $@])Data NB J
⍝
⍝ end ←  newshape ⍴, original
⍝ end =: newshape $, original
⍝
⍝ END TODO

  Data ←  5 2 4 7 ⍴ 1
⍝ Data =: 5 2 4 7 $ 1  NB. J
  ⎕IO ← 0
  ,[0 1]Data
  ,[1 2]Data
  ⍝ TODO find better version in J
⍝ 1(,@:]$~ [(]#~  [~:  ([:i.#)@:])  $@])Data NB. J TODO only works with positives

⍝ P.145/167

⍝ R ←     X|Y                     ⍝ NB. J in also |
⍝ R ←     Y- X×  ⌊  Y÷X+X=0
  R ←  { ⍵- ⍺×  ⌊  ⍵÷ ⍺+ ⍺=0 }  ⍝   this could be a "Magic function"
⍝ R =: {{y- x*  <. y% x+ x=0}}  NB. J
  R ←  ( ⊢- ⊣×( ⌊  ⊢÷ ⊣+ 0=⊣))
⍝ R =: ( ]- [*[:<. ]% [+ 0=[ )  NB. J

⍝ Chapter D ===================================================================

⍝ P.152/174

⍝ P.153/175

  Hypo ←  {       (+⌿   ⍵*2)*0.5 }
⍝ Hypo =: {{       +/&.(^&2)y   }}  NB. J
  Hypo ←  ( *∘0.5 (+⌿   *∘2)     )
⍝ Hypo =:          +/&.(^&2)        NB. J

  V ←  6 8 4 11 9 14 7
⍝ V =: 6 8 4 11 9 14 7  NB. J
  { (×⌿⍵) * ÷≢⍵ }V
⍝ {{(*/y) ^ %#y}}V  NB. J
  (  ×⌿   * ÷∘≢ )V
⍝ (  */   ^ %@# )V  NB. J

⍝ P.160/182
⍝ with ⎕VR 'function' the result is a character string
⍝ can I do the same in J for direct-def and explicit-def?

⍝ P.161/183
  Forecast ←  4 6 ⍴ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350
  Actual   ←  4 6 ⍴ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363
⍝ Forecast =: 4 6 $ 150 200 100 80 80 80 300 330 360 400 500 520 100 250 350 380 400 450 50 120 220 300 320 350  NB. J
⍝ Actual   =: 4 6 $ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363  NB. J

⍝ in NARS2000
      ⎕VR 'Interlace'
    ∇ R←A Interlace B;size;even
[1]   size←1 2×⍴A
[2]   R←size⍴0
[3]   even←2×⍳(⍴B)[2]
[4]   R[;even]←B
[5]   R[;even-1]←A
    ∇ 2021 4 23 2 57 15 26 (UTC)
⍝ can this be done with ()} in J in an explicit-definition?


  Interlace ←  {  ,⍤2 ⍺,⍤0 ⍵  }
⍝ Interlace =: {{ ,"2 x,"0 y }}  NB. J
  Interlace ←  (  ,⍤2  ,⍤0    )
⍝ Interlace =:    ,"2  ,"0       NB. J

⍝ P.164/186
⍝ D-1
  Extract ←  ↑
⍝ Extract =: {.                           NB. J
  ⎕IO ← 0
  Extract ←  {  ⍵ ⌿⍨     ⍺>     ⍳ ≢ ⍵  }
⍝ Extract =: {{ y #~     x>     i.# y }}  NB. J
  Extract ←  (  ⊢(⌿⍤1)⍨  ⊣>   ⊢∘⍳∘≢   )
⍝ Extract =:    ] #~     [>  [:i.@#]      NB. J

⍝ D-2
  Ignore ←  ↓
⍝ Ignore =: }.                            NB. J
  ⎕IO ← 0
  Ignore ←  {  ⍵ ⌿⍨     ⍺≤      ⍳ ≢ ⍵  }
⍝ Ignore =: {{ y #~     x<:     i.# y }}  NB. J
  Ignore ←  (  ⊢(⌿⍤1)⍨  ⊣≤    ⊢∘⍳∘≢    )
⍝ Ignore =:    ] #~     [<:  [:i.@#]      NB. J

⍝ D-3
  Reverse ←  ⌽
⍝ Reverse =: |.                               NB. J actually ⊖ is |.
  ⎕IO ← 0
  Reverse ←  {  ⍵⌷⍨  ⊂ | (≢⍵)-⍨  1+⍳   ≢⍵  }
⍝ Reverse =: {{ y{~    | (#y)-~  1+i.  #y }}  NB. J
  Reverse ←  (  ⊢⌷⍨  ⊂∘|∘(  ⊢-⍨ (1+⍳))∘≢   )
⍝ Reverse =:    [{~    |@:( ]-~  1+i.)@#      NB. J

⍝ D-4
  Mat ←  3 4⍴ 75 14 86 20   31 16 40 51   22 64 31 28
⍝ Mat =: 3 4$ 75 14 86 20   31 16 40 51   22 64 31 28  NB. J
  Totalise ←  {  ⍉  ⍵⍪ +⌿⍵  }⍣ 2
⍝ Totalise =: {{ |: y, +/y }}^:2                       NB. J
  Totalise ←  (  ⍉  ⊢⍪ +⌿   )⍣ 2
⍝ Totalise =: ([:|: ], +/   )^:2                       NB. J

⍝ D-5
  Lengths ←  'This seems to be a good solution'
⍝ Lengths =: 'This seems to be a good solution'  NB. J
  {  {  -⌿  ⊖   ¯1↓ ⍤1  (0, 1+1↓ ⍵)⍪[¯.5] 1⊖ ⍵  }(≢⍵),⍨    ∪  (⍳ ≢⍵)×  ' '=⍵  }Lengths
⍝ {{ {{ -/  |.  _1}."1  (0, 1+ }.y),:     1|.y }}(#y),~    ~. (i.#y)*  ' '=y }}Lenghts  NB. J
  (  (  -⌿∘ ⊖  (¯1↓ ⍤1  (0, 1+1↓ ⊢)⍪[¯.5] 1⊖ ⊢ ))   ≢,⍨   (∪   ⍳∘≢  ×  ' '=⊢ ))Lengths
⍝ ([:([:-/@:|.  _1}."1  (0, 1+ }. ),:     1|.]  )   #,~  [:~.  i.@:#*  ' '=]  )Lengths  NB. J

⍝ D-6
  ⎕IO ← 0
  To ←  {  ⍺+    ⍳   1+⍵-⍺  }
⍝ To =: {{ x+    i.  1+y-x }}  NB. J
  To ←  (  ⊣+  ( ⍳  (1+ -⍨)))
⍝ To =:    [+  [:i.  1+ -~     NB. J
17 to 29

⍝ P.165/187
⍝ D-7
  Towns ←  6 10 ⍴ 'Canberra  ','Paris     ','Washington','Moscow    ','Martigues ','Mexico    '
⍝ Towns =: 6 10 $ 'Canberra  ','Paris     ','Washington','Moscow    ','Martigues ','Mexico    ' NB. J

  ⎕IO ← 0
  Frame ←  { { ⍵{ ⍵⍪⍺⍪⍵ }'+'{ ⍺,⍵,⍺ }'-'⌿⍨¯2+1⌷⍴⍵ }               ⍵ { ⍵,⍺,⍵ }⍤1⍪'|' }
⍝ Frame =: {{{{y{{y,x,y}}'+'{{x,y,x}}'-'#~_2+1{$y}}((_2{.1,$,:y)$,y){{y,x,y}}"1 '|'}}  NB. J

⍝ Unicode 9484 9488 9492 9496  ┌ ┐ └ ┘ ⋄ Unicode 9472 9474 ─ │
  Frame←{                                                                                       
  (V H C) ←  (⎕UCS 9474)(⎕UCS 9472)(⎕UCS 9484 9488 9492 9496)          ⍝  Vertical Horizontal Corner
  wV  ←                  ⍵{ ⍵,⍺,⍵ }⍤1  ⍪V                              ⍝  with Vertical bars
  T_B ←  {    C {  ((0⌷⍺),⍵,1⌷⍺)⍪[¯0.5]((2⌷⍺),⍵,3⌷⍺)  }H⌿⍨1⌷⍴⍵  }⍵     ⍝  Top & Bottom
  wV{  (0⌷⍵)⍪⍺⍪1⌷⍵  }T_B
  }
⍝ Frame =: {{                                                          NB. J
⍝ V=.(u:   9474)  [H=.(u:   9472)  [C=.(u:   9484 9488 9492 9496)      NB. Vertical Horizontal Corner (did assignment this way to avoid boxing)
⍝ wV  =. ((_2{.1,$,:y)$,y){{y,x,y}}"1  V                               NB. with Vertical bars
⍝ T_B =. {{ (>C){{ ((0{x),y,1{x),:     ((2{x),y,3{x) }}H#~1{$y }}y     NB. Top & Bottom          (I don't know why C is boxed)
⍝ wV{{ (0{y),x,1{y }}T_B
⍝ }}

  Frame ←  {  { ⍵{ (0⌷⍵)⍪⍺⍪1⌷⍵ }(⎕UCS 9484 9488 9492 9496){ ((0⌷⍺),⍵,1⌷⍺)⍪[¯0.5]((2⌷⍺),⍵,3⌷⍺) }(⎕UCS 9472) ⌿⍨   ¯2+1⌷⍴⍵ }               ⍵ { ⍵,⍺,⍵ }⍤1⍪ (⎕UCS 9474) }
⍝ Frame =: {{ {{y{{(0{y),x,1{y}}(u:   9484 9488 9492 9496){{((0{x),y,1{x),:     ((2{x),y,3{x)}}(u:   9472) #~   _2+1{$y}}((_2{.1,$,:y)$,y){{y,x,y}}"1  (u:   9474)}}        NB. J
  Frame ←     ( ⊢( (0⌷⊢)⍪⊣⍪1⌷⊢ )(⎕UCS 9484 9488 9492 9496)( ((0⌷⊣),⊢,1⌷⊣)⍪[¯0.5]((2⌷⊣),⊢,3⌷⊣) )(⎕UCS 9472)(⌿⍤1⍨)¯2+1⌷⍴  )∘(   (⍪⎕UCS 9474)( ⊣, ,⍨ )⍤1⊢                   )
⍝ Frame =: [: ( ]( (0{]),[,1{] )(u:   9484 9488 9492 9496)( ((0{[),],1{[),:     ((2{[),],3{[) )(u:   9472) #~   _2+1{$  ) (   (u:    9474)( [, ,~ )"1 ((_2{. 1, $@:,:)$,))  NB. J
Frame Towns

⍝ D-8
⍝ made it work on vectors and single characters

⍝ D-9
  ⎕IO ← 0
  Switch1 ←  { w←⍵ ⋄ m←(0⌷⍺)=⍵ ⋄ w[m⌿⍳≢⍵]←(+⌿m)⍴1⌷⍺ ⋄ w} ⍝  m for mask, in Dyalog use @?

  Switch1 ←  { w⊣ w[m⌿⍳ ≢⍵] ←  (+⌿m)⍴ 1⌷⍺  ⊣ m← (0⌷⍺)=⍵ ⊣ w←⍵  } ⍝  m for mask, in Dyalog use @?
⍝ Switch1 =: {{   y(M#i.#y)}~  (+/M)$ 1{x  [ M=.(0{x)=y       }} NB. J Use capital letters for variables in DDs
  Switch1 ←  {   (⍵=0⌷⍺)⌷⍤(0 1)⍥⍉    ⍵⍪[¯.5] 1⌷⍺  }
⍝ Switch1 =: {{  (y=0{x){"(0 1)&.|:  y,:     1{x }}              NB. J
  Switch1 ←  (   (⊢=0⌷⊣)⌷⍤(0 1)⍥⍉    ⊢⍪[¯.5] 1⌷⊣  )              ⍝ Tacit programming plays better without using 'ammend'
⍝ Switch1 =: (   (]=0{[){"(0 1)&.|:  ],:     1{[  )              NB. J
'tc' Switch1 'A bird in the hand is worth two in the bush'

⍝ D-10
  ⎕IO ← 0
  Switch2 ←  {  (  +⌿ 1 2×⍤(0 1) ⍵=⍤(1 0)⍺  )⌷⍤(0 1)  (⍪ ⍵)⍪⍤1 ⊖ ⍺  }
⍝ Switch2 =: {{ (  +/ 1 2*"(0 1) y="(1 0)x  ){"(0 1)  (,.y),"1 |.x }}  NB.J
  Switch2 ←  (  (( +⌿(1 2×⍤(0 1) ⊢=⍤(1 0)⊣)))⌷⍤(0 1)  (⍪ ⊢)⍪⍤1(⊖ ⊣) )  ⍝ NARS2000 is being real pick about parrens
⍝ Switch2 =:    ([:+/ 1 2*"(0 1) ]="(1 0)[  ){"(0 1)   ,.@],"1 |.@[    NB. J
'ei' Switch2 'A bird in the hand is worth two in the bush'

⍝ P.166/188
⍝ P.167/189
⍝ P.168/190

⍝ APL                  | J
⍝====================================
⍝ :If     :EndIf       | if.                     do.    end.
⍝ :For    :EndFor      | for./for_ijk.           do.    end.
⍝ :Select :EndSelect   | select. -> case./fcase. do.    end.
⍝ :Repeat :Until       | 
⍝         :EndRepeat   |
⍝ :While  :EndWhile    | while./whilst.                 end.
⍝         :Until       |
⍝ :Trap   :EndTrap     | try. catch./catchd.(debug)/catcht.(with throw.) (no end.?) 
⍝ :With   :EndWith     |
⍝ :Hold   :EndHold     | check 18!:n

⍝ :Else                | else.
⍝ :ElseIf              | elseif.
⍝ :AndIf               |
⍝ :Orif                |
⍝ :Case                | case./fcase. 
⍝ :Caselist            |
⍝ :Until               |

⍝ :GoTo                | goto_lbl. label_lbl.
⍝ :Return              | return.
⍝ :Leave               | break.
⍝ :Continue            | continue.

⍝ P. 170/192
  Quadroot←{                 
  D←(b*2)-4×a×c ⊣ (a b c)←⍵
  D≥0: (2×a)÷⍨(-b)+1 ¯1×D*0.5
  D<0:'No roots'             
  }     
⍝ Quadroot =: {{                       NB. J
⍝ D=.(b^2)-4*a*c ['a b c'=.y 
⍝ if. D>:0 do. (2*a)%~(-b)+1 _1*D^0.5 
⍝ else. 'No roots' 
⍝  }}

  Quadroot ←  { D← (b*2)-4×a×c ⊣ (a b c)← ⍵ ⋄D≥0: (2×a)÷⍨(-b)+1 ¯1×D*0.5 ⋄D<0:'No roots'}
⍝ Quadroot =: {{('No roots'"_ `((2*a)%~(-b)+1 _1*D^0.5"_))@.(D>:0) [D=.(b^2)-4*a*c ['a b c'=.y }} NB.J
⍝ TODO is a train worth it?

⍝ TODO tacit control flow APL? simple guards in J require IF?

⍝ P.171/193
⍝ P.172/194
⍝ P.173/195
⍝ P.174/196
⍝ P.175/197
⍝ P.176/198
⍝ P.177/199
⍝ P.178/200
  ⎕IO ← 0
  Divisors2 ←  {  ⍵   {  ⍵⌿1+⍳ ⍺  }{  ⍵=⌊ ⍵  } ⍵÷  1+⍳ ⍵  }
⍝ Divisors2 =: {{ y   {{ y#1+i.x }}{{ y=<.y }} y%  1+i.y }}
  Divisors2 ←  ( (1+⍳)  (⌿⍤1)⍨     (( ⊢=⌊    ) ⊢÷  1+⍳   ))
⍝ Divisors2 =:   (1+⍳)   #~       [:( ]=<.   ) ]%  1+i.
Divisors2 3219

⍝ p.179/201
⍝ p.180/202
⍝ p.181/203
⍝ p.182/204
⍝ p.183/205
⍝ p.184/206
⍝ p.185/207
⍝ p.186/208
⍝ p.187/209
⍝ p.188/210
⍝ p.189/211
⍝ p.190/212
⍝ p.191/213
⍝ p.192/214
⍝ p.193/215
⍝ p.194/216

⍝ p.195/217
  Chemistry ← 3 5⍴ 'H2SO4', 'CaCO3', 'Fe203'
⍝ Chemistry =: 3 5$ 'H2SO4', 'CaCO3', 'Fe203'                 NB. J
  ⎕IO ← 0
  One ← 2 2 ⍴ 8 6 2 4 ⋄ Two ← 'Hello' 
⍝ One =: 2 2 $ 8 6 2 4 [ Two =: 'Hello'                       NB. J
  NesMat ← 2 3 ⍴ 'Dyalog' 44 Two 27 One (2 3⍴1 2 0 0 0 5)
⍝ NesMat =: 2 3 $ 'Dyalog'; 44; Two; 27; One; 2 3$1 2 0 0 0 5 NB. J

⍝ Formatting is implementation specific for nesting/boxing!
  ⍴⍕ NesMat
3 20  ⍝ Dyalog
4 24  ⍝ NARS2000 (has added whitespace between nested values)
⍝ $":NesMat
6 18  ⍝ J (includes boxing)

  MN ←  3 4 ⍴ 608.1 928.24 1293.14 849.95, 1127.84 970.27 1249 1168.29, 775.12 1065 670.69 1091.7
⍝ MN =: 3 4 $ 608.1 928.24 1293.14 849.95, 1127.84 970.27 1249 1168.29, 775.12 1065 670.69 1091.7  NB. J

  8 2⍕ MN
⍝ 8j2":MN  NB. J

⍝ Note to self, NARS2000 ~8j2≡8J2 (ie: not eqivalent)
⍝ 8i2≡8J2 ⋄ 8j2≡8i0j2k0 (quaternions)

⍝ p.203/225
  in  ←  ⎕ ⍝ numeric input
  put ←  ⍞ ⍝ character input
  in←⎕⋄put←⍞⋄in(/¨)put
⍝ this doesn't apear to be supported in J, but it can be done with
⍝ use of the shell 
⍝ cat <<EOF | jconsole -js 'program'
⍝ you would likely have to format the strings befor input would work

⍝ p.211/233
  Addr ←  'London' 'UK' 7684700 40 
⍝ Addr =: 'London';'UK';7684700;40 
  ⍕⍤0⊢ Addr
 London ⍝ note the space before the 'L' in 'London', the 'n' is above the last '0'
 UK     
7684700 
40      
⍝ ":@> Addr  NB. J
London  ⍝ in J it aligns on the left
UK     
7684700
40     

⍝ p.218/240
  Dfact ←  {  ⍵=1:1⋄ ⍵× ∇ ⍵-1        }
⍝ Dfact =: {{    1:`(]* $:@<:)@.* y }}  NB. J
  Dfact ←  {     
⍝ Dfact =:       1:`(]* $:@<:)@.*       NB. J

⍝ p.227/249

⍝ D-11
  IO ← 0
  Actual   ←  4 6 ⍴ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363
⍝ Actual   =: 4 6 $ 141 188 111 87 82 74 321 306 352 403 497 507 118 283 397 424 411 409 43 91  187 306 318 363  NB. J

MaxPlace ←  {
  g←⌈/⍣2 ⍵
  p←(⍴⍵)⊤(,⍵)⍳ g
  'The greatest value: ',(⍕g),', is in row ',(⍕1↑p),', column ',⍕1↓p}
}
⍝ MaxPlace =: {{ NB. J
⍝ g=.>./^:2 y 
⍝ p=.($y)#:(,y)i.g
⍝ 'The greatest value: ',(":g),', is in row ',(":{.p),', column ',":}.p
⍝ }}

  MaxPlace ←  {  'The greatest value: ',(⍕ g),   ', is in row ',(⍕ 1↑p),    ', column ',  ⍕   1↓ p← (⍴⍵)⊤ (,⍵)⍳  g←   ⌈/ , ⍵  }
⍝ MaxPlace =: {{ 'The greatest value: ',(":g),   ', is in row ',(":{.p),    ', column ',  ":  }. p=.($y)#:(,y)i. g=.  >./, y }} NB. J

⍝ MaxPlace ←  (  'The greatest value: ',(⍕ g),   ', is in row ',(⍕ 1↑p),    ', column ',  ⍕∘( 1↓ p←    ⍴⊤    ,⍳  g←   ⌈/∘,   )) ⍝ APL tacit fail:can i do internal assignment in tacit APL?
⍝ MaxPlace =:    'The greatest value: ',(":@g"_),', is in row ',(":@{.@p"_),', column ',[:":@}. p=.    $#:   ,i. g=.[:>./,      NB. J

⍝ D-12
  Convert ←  {  'C-F'≡⍵:32+(9÷5)×⍺ ⋄ 'F-C'≡⍵: (5÷9)×¯32+⍺  }
⍝ Convert =: {{ (".@,&'a')`(".@,&'^:_1 a')@.(('C-F';'F-C')i.<y) '(32+(9%5)*])' [a=.x}} ⍝ NB. J
⍝ Convert ←  (  (32+(9÷5)×⊣)⍣(⊢∘(1 ¯1⌷⍨ 1⍳⍨ (2 3⍴'C-FF-C')≡⍤1 ⊢)))                     ⍝ APL Fail: do I need a d-fn?
⍝ Convert =:    ((32+(9%5)*])@[)`((32+(9%5)*])^:_1@[)@.(('C-F';'F-C')"_ i.<@])         ⍝ NB. J this can be made cleaner if C° to F° was defined earlier

⍝ D-13
⍝ TODO make it a FOR loop
  ⎕IO ← 0
  ∇ r←LoopSum v;a
    a←(¯1+≢v),0
    :While 0≤1↑a ⋄  a←a+¯1,v⌷⍨1↑a
    :EndWhile    ⋄  r←1↓a
  ∇
⍝ LoopSum =: {{  NB. J
⍝ a=. (<:#y), 0
⍝ while. 0<:{.a do. a=.a+_1,y{~{.a
⍝ end. }.a
⍝ }}

  RecSum ←  {  1=≢⍵:⍵ ⋄ (1↑⍵)+∇1↓⍵      }
⍝ RecSum =: {{ ({.+[:$:}.)`]@.(1=#@])y }} NB. J
  RecSum ←  {  1=≢⍵:⍵ ⋄ (1∘↑+(∇1∘↓))⍵   }
⍝ RecSum =:    ({.+[:$:}.)`]@.(1=#@])     NB. J

⍝ D-14
⍝ TODO make it a FOR loop
  ⎕IO ← 0
  ∇ r←ReverLoop v;i;a
    (i a)← (¯1+≢v) ''
    :While 0≤i ⋄ (i a)← (i-1) (a,i⌷v)
    :EndWhile  ⋄ r ← a
  ∇

⍝ ReverLoop =: {{ NB. J
⍝   'i a'=. (<:#y); ''
⍝   while. 0<i do. 'i a'=. (i-1);(a,i{y)
⍝   end.   a
⍝ }}

  ReverLoop ←  {  1≡≢⍵:⍵ ⋄ (¯1↑⍵),∇¯1↓⍵ }
⍝ ReverLoop =: {{ (_1&{., [: $:_1&}.)`]@.(1-:#)y }}  NB. J
  ReverLoop ←  {  1≡≢⍵:⍵ ⋄ (¯1∘↑,(∇¯1∘↓))⍵ }
⍝ ReverLoop =:    (_1&{., [: $:_1&}.)`]@.(1-:#)      NB. J

⍝ p.228/250
⍝ D-15
  Twelve ←  3 12 ⍴ 51 40 18 90 72 75 13 4 35 18 95 29, 85 20 87 6 60 3 53 73 32 34 10 36, 40 60 56 33 60 3 15 60 63 18 63 5
⍝ Twelve =: 3 12 $ 51 40 18 90 72 75 13 4 35 18 95 29, 85 20 87 6 60 3 53 73 32 34 10 36, 40 60 56 33 60 3 15 60 63 18 63 5 NB. J

  SubSum ← {
    (0=⍺| ¯1↑⍴⍵)∧(1=≢⍺):
   
    (h d) ← (¯1↓⍴⍵) (⌈¯0.1+  ⍺÷⍨¯1↑⍴⍵)
    (h,d+¯1↑⍴⍵)⍴  {⍵⍪⍤(1 0)+⌿⍤1⍵}  ⍵⍴⍨h,d,⍺
  }

⍝ SubSum =: {{ NB. J
⍝   if. (-.(0=x| _1{.$y)*.(1=#x)) do. throw. end. 
⍝
⍝   'h d' =. (_1}.$y) ; (>._0.1+  x%~_1{.$y)  
⍝   (h,d+_1{.$y)$,  {{ y,."(2 1)+/"1 y }}  (,y)$~h,d,x 
⍝ }}

⍝ no guards, ⎕CT isn't 0
  SubSum ← ( ((¯1↓⊢∘⍴ ),⊣(⊢+÷⍨)¯1↑ ⊢∘⍴)⍴   (  (⊢(⍪⍤( 1 0))+⌿⍤1)    (⊢⍴⍨(¯1↓ ⊢∘⍴),((¯1↑⊢∘⍴)÷⊣),⊣)) )
⍝ SubSum =:                     (h,e+d)$ ,@([:(] ,."(2 1) +/"1)  ,@]$~h,d,[)                       [h=._1}.$@][d=.e%[[e=._1{.$@]  NB. J 

⍝ D-16
'/' Sorry 'You/will/need a/loop/to solve/this/exercise'
⍝ TODO make them for loops
⍝ the return will be a nested shape(n 1) array of character vectors, you can use ⍕ for a character matrix based on format
  ∇r ← c Sorry v ;i;s;t 
    (i s t) ← ⎕IO '' ''
    :While i≤(≢v)+⎕IO-1 
      :If c=i⌷v ⋄ t,← ,⊂,s  ⋄ s ← '' ⋄ :Else ⋄ s ,← i⌷v 
      :EndIf    ⋄ i+←1
    :EndWhile   ⋄ r ← ⍪t,⊂,s
  ∇

⍝ Sorry =: {{ NB. J note that for the same result as the APL example, remove @:>
⍝   'i s t' =. 0;'';'' 
⍝   while. i<#y do. 
⍝     if. x=i{y do. s=.''[t=.t,<,s  else. s =. s,i{y 
⍝     end.          i=.i+1 
⍝   end.            ,.@:>t,<s 
⍝ }}   

⍝ TODO recursive?

⍝ p.229/251
  Syracuse ← {1≡⍵:⍵ ⋄ 0≡2|⍵:⍵,∇⍵÷2 ⋄ 1≡2|⍵: ⍵,∇1+3×⍵}
⍝ Syracuse =:{{ (], [:$: %&2)`(], [:$: 1+3&*)`]@.(1&-: + 1-:2&|)y }} NB. J (1? + odd?) => 0 even,1 odd,2 one
⍝ Syracuse =:   (], [:$: %&2)`(], [:$: 1+3&*)`]@.(1&-: + 1-:2&|)

⍝ p.239/261
⍝ p.243/265

  ∇ Z←Upper T;A
    A ←  ⎕a,⎕A     ⍝ in Dyalog ⎕C instead of ⎕a
    T (∊(⌿⍤1)⊣)← A
    Z ← (,⍨⎕A)⌷⍨⊂A⍳T
  ∇
⍝ Upper =:{{ NB. J
⍝   'aA AA'=.,/"2 a.( [{~  i.+ i.@26"_ )"(1 0) 'aA',: 'AA'
⍝   T=.y(e.#[)aA
⍝   AA{~aA i.T 
⍝ }}

  Upper ← {A ← ⎕a,⎕A ⋄ T ← ⍵(∊(⌿⍤1)⊣)A ⋄ (,⍨⎕A)⌷⍨⊂A⍳T}   ⍝ ⎕C instead of ⎕a in Dyalog
⍝ Upper =:{{    AA{~aA i.T[T=.y(e.#[)aA                [ 'aA AA'=. ,/"2 a.( [{~ i.+ i.@26"_ )"(1 0) 'aA',: 'AA' }}  NB. J

  Upper ←  ((⎕a,⎕A)  (⊣ ((,⍨⎕A)⌷⍨∘⊂ ⍳ ) (∊(⌿⍤1)⊣)⍨)  ⊢)  ⍝ ⎕C instead of ⎕a in Dyalog
⍝ Upper =:      aA   ([ (   AA{~    i.) (e.#[)~   )  ] [('aA AA'=. ,/"2 a.( [{~ i.+ i.@26"_ )"(1 0) 'aA',: 'AA')"_   NB.J


⍝ One Problem, Five Programming Languages LIVE! (2021/05/17)
⍝ replaceDigits =:    {., 2 (]`([: u: ".@] + 3 u:[)@.([e.aA"_))/\ ] [aA=. [: ,/"2 a.( [{~ i.+ i.@26"_ )"(1 0) 'aA'"_ 
⍝   NB. the last part is to make an ⎕C⎕A string
⍝ replaceDigits =: {{ ({.y), 2 {{if.(x e. aA)do. u:(".y)+3 u:x else.y end. }}/\ y [aA=: , (3&u: u:@:+ i.@26"_)"0 'aA' }}  
⍝   NB. Closest to your APL version, unfortunatly I used a global assignment to use if else as a guard.

⍝ p.244/266
  Upper ←  ((⎕a,⎕A)  (⊣ ((,⍨⎕A)⌷⍨∘⊂ ⍳ ) (∊(⌿⍤1)⊣)⍨)  ⊢)  ⍝ ⎕C instead of ⎕a in Dyalog
⍝ Upper =:      aA   ([ (   AA{~    i.) (e.#[)~   )  ] [('aA AA'=. ,/"2 a.( [{~ i.+ i.@26"_ )"(1 0) 'aA',: 'AA')"_   NB.J
  Palindrome ←  ((⊢≡⊖)∘Upper)⍤1
⍝ Palindrome =: ((]-:|.)@Upper)"1

Palindrome 'Was it a car or a cat I saw?'
Palindrome 'Am I a palindrome?'


⍝ From Aaron Hsu
 meanTimes2←(times←2×⊢)∘(m←+⌿÷≢) ⍝ this doesn't work in Nars2000
      meanTimes2
 2 ×⊢ ∘  +⌿ ÷≢
      times
2 ×⊢
      m
 +⌿ ÷≢
      meanTimes2 3 1 4 1 5 2 6
6.285714286
      m 3 1 4 1 5 2 6
3.142857143

⍝ DFN version
meanTimes2←{times2←(2×⊢) ⋄ m←(+⌿÷≢) ⋄ times2 m ⍵} ⍝ Nars2000 version
meanTimes2←{times2←2×⊢ ⋄ m←+⌿÷≢ ⋄ times2 m ⍵}
      meanTimes2 3 1 4 1 5 2 6
6.285714286

⍝ DFN hide bindings

{m←(+⌿÷≢) ⋄ z←(2+m) ⋄ t2←(2×⊢) ⋄ mt2←(t2∘m) ⋄ (m,z,mt2)3 1 4 1 5 2 6}⍬
{m←+⌿÷≢ ⋄ z←2+m ⋄ t2←2×⊢ ⋄ mt2←t2∘m ⋄ (m,z,mt2)3 1 4 1 5 2 6}⍬
3.142857143 5.142857143 6.285714286

























⍝ P.361/383
⎕IO ← 0
One ← 2 2 ⍴ 8 6 2 4 ⋄ Two ← 'Hello' 
⍝ One =: 2 2 $ 8 6 2 4 [ Two =: 'Hello'                       NB. J
NesMat ← 2 3 ⍴ 'Dyalog' 44 Two 27 One (2 3⍴1 2 0 0 0 5)
⍝ NesMat =: 2 3 $ 'Dyalog'; 44; Two; 27; One; 2 3$1 2 0 0 0 5 NB. J
Weird ← 2 2⍴ 456 (NesMat[;0 1]) (17 51) 'Twisted'             ⍝ NesMat[0 1;0 1]
Weird ← 2 2⍴ 456 ((0 1)(0 1)⌷⍤(1 99)NesMat) (17 51) 'Twisted'
⍝ Weird =: 2 2$ 456; ((<;~0 1){NesMat) ; 17 51; 'Twisted'     NB. J

⍝ P.362/384
(1 0) 1 ⊃ Weird
⍝ 1{>(<1 0){Weird         NB. J
(0 1) (0 0) 5 ⊃ Weird
⍝ 5{>(<0 0){>(<0 1){Weird NB. J
(⊂0 1) ⊃ Weird
⍝ 0 1 { Wierd             NB. J

(0 1)⊃'Madrid' 'New York' 'London'
⍝ 1{>0{'Madrid';'New York';'London'

Hogwash ← 19 (2 2⍴⍳4) (3 1⍴'APL') (2 2⍴5 8 'Nuts' 9)
⍝ Hogwash =: (19),(<2 2$i.4),(<3 1$'APL'),(<2 2$5;8;'Nuts';9)

















⍝ extras:

⍝ Dyalog Primitives: Rank
⍝ http://help.dyalog.com/14.0/Content/Language/Primitive%20Operators/Rank.htm

Y ← 2 3 4⍴36 99 20 5,63 50 26 10, 64 90 68 98,66 72 27 74,44 1 46 62,48 9 81 22
⍝ Y =:2 3 4$36 99 20 5,63 50 26 10, 64 90 68 98,66 72 27 74,44 1 46 62,48 9 81 22 NB. J
⊂⍤2 Y    ⍝ <"2 Y       NB.J

PiDgt ← 3 1 4 1 5 9 2 6 5
⍝ PiDgt =: 3 1 4 1 5 9 2 6 5
⍝ Sort
Sort ← {(⊂⍋⍵)⌷⍵}  
Sort ← (⊂∘⍋ ⌷⊢)
⍝ Sort =: {{ (/:y) {y }} NB. J
⍝ Sort =: /:{] NB. J
Sort PiDgt
Sort⍤1 Y
⍝ Sort"1 Y NB.J

⍝ Nars2000 can use [] for left rank argument, 
⍝ but it causes wierd behavior to be avoided, 
⍝
⎕BOX on
⍝ Put the tuple in a Parrens after rank for consistancy
    10 20 30    +⍤(0  1) 3 4⍴⍳ 12   ⍝ best solution
    10 20 30   (+⍤ 0  1) 3 4⍴⍳ 12   ⍝ Dyalog okay, NARS2000 infinite loop
    10 20 30   (+⍤[0] 1) 3 4⍴⍳ 12   ⍝ NARS2000 length error
    10 20 30   (+⍤[0] 1)⍉3 4⍴⍳ 12   ⍝ NARS2000 quirk
    ⍝ 10 20 30  +"(0  1) 3 4$i.12  NB. J
10 11 12 13
24 25 26 27
38 39 40 41
    ⍝
    10 20 30 40  (+⍤[0] 1)  3 4⍴⍳ 12  ⍝ NARS2000 bracket quirk
    10 20 30 40   +⍤(0  1)  3 4⍴⍳ 12  ⍝ Dyalog length error
    10 20 30 40   +⍤(0  1) ⍉3 4⍴⍳ 12  ⍝ best solution
    ⍝ 10 20 30 40 +"(0  1)|:3 4$i.12 NB. J
10 14 18
21 25 29
32 36 40
43 47 51
    ⍝
    ⍝ No issue once rank is 1
    10 20 30 40   (+⍤[1] 1)3 4⍴⍳ 12   ⍝ NARS2000
    10 20 30 40    +⍤(1  1)3 4⍴⍳ 12
    ⍝ 10 20 30 40  +"(1  1)3 4$i.12  NB. J
10 21 32 43
14 25 36 47
18 29 40 51
    ⍝
    10 20 30   { ⍺ ⍵ }⍤(0 1)        3 4⍴⍳ 12
    10 20 30   (⊣  ,  ⊢∘⊂ )⍤(0 1)   3 4⍴⍳ 12
    10 20 30   (⊣  ,⍤0 ⊢∘⊂⍤1 )      3 4⍴⍳ 12   ⍝ explict per operator version
    ⍝ 10 20 30 {{ x;y }}"(0 1)3 4$i.12  NB. J
    ⍝ 10 20 30 ( ;" 0 1) 3 4$i.12       NB. J
┌──┬─────────┐
│10│0 1 2 3  │
├──┼─────────┤
│20│4 5 6 7  │
├──┼─────────┤
│30│8 9 10 11│
└──┴─────────┘
⎕BOX off