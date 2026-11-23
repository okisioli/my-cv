#import "variables.typ" as theme
#import "components.typ": block-top-2, markdown

#let introduction-section(introduction) = [
  #block(inset: theme.heading-padding)[
    #text(..theme.section-title-text, introduction.title)
  ]
  #block-top-2(
    grid(columns: (5fr, 2fr), markdown(introduction.summary), []),
  )
]
