#import "themes/default/theme.typ": render

#let cv = json("cv.json")
#set document(..cv.document)
#render(cv)
