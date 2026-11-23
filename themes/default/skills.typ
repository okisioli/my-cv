#import "variables.typ" as theme
#import "components.typ": accent-list-marker, block-top-1, markdown

#let skills-column(heading, body) = [
  // Skills keep their own symbol, with the same appearance as achievements.
  #block(..theme.skills-column-style.heading-block)[
    #text(..theme.skills-column-style.heading-text)[
      #heading
    ]
  ]
  #set list(marker: accent-list-marker(theme.skills-list-marker))
  #show list.where(): it => block(inset: theme.skills-column-style.list-inset)[
    #it
  ]
  #text(size: theme.skills-column-style.body-size)[
    #body
  ]
]

#let skills-section(groups) = block-top-1(
  grid(
    columns: 1,
    grid(
      columns: (1fr,) * groups.len(),
      gutter: theme.skills-grid-gutter,
      ..groups.map(group => skills-column(
        group.title,
        list(..group.items.map(markdown)),
      )),
    ),
    [],
  ),
)
