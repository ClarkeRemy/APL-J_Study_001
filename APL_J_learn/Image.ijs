NB. PPM P3 ascii format
NB. P3 height width depth(255) pixel(colors separated by spaces)

NB. P3
NB. 3 2
NB. 255

NB. 255   0   0
NB.   0 255   0
NB.   0   0 255
NB. 255 255   0
NB. 255 255 255
NB.   0   0   0

NB. PPM P6 Binary format (spaces are okay)
NB. P6 heightAscii widthAscii depth(255) 

intoP3=. ('P3 ', ":@}:@:$, LF, ' 255 ',LF"_)  , ([:, LF,"1 [:,"2 ' ',"1 ":"0)    : [: NB. expects 3D Array
intoP6=. ('P6 ', ":@}:@:$, ' 255 '"_) , a.{~ ,  : [: NB. ex

NB. [S) Height width (colors = 3) |D) subpixels ]  internal image format
TestImg=. 256 256 3 $ , |:(i._256),0,:(i.256) 
intoP3 TestImg
intoP6 TestImg


decDump =. i.@:{.@:$ (,"0 1) 1|: ]
idx     =. {{ >{<@i."0}:y }}@$                                : [:
toHex   =. [: (,"1)@:({&'0123456789ABCDEF') 16 16&(#:"1 0)    : [:
rgbHex  =. (,/"2)@:toHex                                      : ([:  }."1@:(,/"2)  (,"1 toHex))
hexList =. '  [',"1   ":@:idx@:] (,"1)   '] ',"1   rgbHex
hexDump =. ,/"2 @:({ hexList)

avgBW    =.(+/ % #)&.:*:"1

TestImg
decDump TestImg
toHex TestImg
' ' rgbHex TestImg
rgbHex TestImg
'.' hexList TestImg
hexList TestImg
(< a:; i.8) hexDump TestImg

(intoP6 TestImg) fwrite 'ppm_P6_test.ppm'
(intoP3 TestImg) fwrite 'ppm_P3_test.ppm'
jcwdpath ''