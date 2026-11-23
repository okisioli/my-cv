#import "variables.typ" as theme
#import "components.typ": block-top-1

#let info-table(..args) = table(
  ..theme.info-table-style,
  ..args,
)

#let footer(languages, education, contact) = block-top-1[
  #grid(
    column-gutter: theme.footer-grid-column-gutter,
    columns: (3fr, 2fr, 2fr),
    [
      = #languages.title
      #info-table(
        columns: (1fr, 1.5fr),
        strong(languages.languageHeading), strong(languages.levelHeading),
        ..languages.entries.map(entry => (entry.language, entry.level)).flatten(),
      )
      #block(inset: theme.footer-contact-style.inset)
      #text(size: theme.footer-contact-style.text-size, contact.phone)
      #contact.email
    ],
    [
      = #education.title
      #info-table(
        columns: (1fr,),
        strong(education.program),
        education.institution,
        education.dates,
      )
    ],
    [],
  )
]
