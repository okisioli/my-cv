#import "variables.typ" as theme
#import "components.typ": accent-list-marker, section-page-background, section-page-borders
#import "header.typ": header
#import "introduction.typ": introduction-section
#import "skills.typ": skills-section
#import "experience.typ": experience-section
#import "footer.typ": footer

#let cv-theme(body) = [
  #set page(
    paper: theme.page-paper,
    margin: (top: theme.page-top-padding, bottom: 0pt, x: 0pt),
    // The Introduction heading and the space below the header sit outside section blocks.
    fill: if theme.dark-mode { theme.section-color } else { none },
    background: section-page-background(),
    foreground: section-page-borders(),
  )
  #set text(size: 9.7pt, ..theme.cv-text)
  #set list(indent: 0.5em, body-indent: 0.45em)

  #show heading.where(level: 1): it => block(inset: (bottom: 0.5em))[
    #text()[
      #it.body
    ]
  ]

  // Keep heading spacing explicit; inset controls the padding around the text.
  #show heading.where(level: 2): it => block(
    above: 0pt,
    below: 0pt,
    inset: (top: 0.1em, bottom: 0.8em),
    sticky: true,
  )[
    #text()[
      #it.body
    ]
  ]

  #show heading.where(level: 3): it => block(inset: (top: 0em, bottom: 0.2em), sticky: true)[
    #text()[
      #it.body
    ]
  ]

  #show list.where(): it => block(inset: (top: 0.25em, bottom: 1em))[
    #it
  ]

  #set par(justify: false)
  #set list(body-indent: 0.75em)

  #set list(marker: accent-list-marker(theme.achievement-list-marker))

  #body
]

#let render(cv) = cv-theme[
  #header(cv.profile)
  #introduction-section(cv.introduction)
  #skills-section(cv.skills)
  #experience-section(cv.experience, cv.freelance, cv.personalProjects)
  #footer(cv.languages, cv.education, cv.footerContact)
]
