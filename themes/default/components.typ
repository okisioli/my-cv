#import "variables.typ" as theme
#import "@preview/cmarker:0.1.10"

#let markdown(source) = cmarker.render(source, raw-typst: false)

// Shared marker appearance for skills and achievements. Scaling is visual only,
// so the heavier, larger characters do not increase line spacing.
#let accent-list-marker(symbol) = scale(110%, reflow: false, text(
  weight: "black",
  fill: theme.accent-color,
  // Keep the marker heavy even when Arial falls back to its bold face.
  stroke: 0.12pt + theme.accent-color,
  symbol,
))

#let h2(title) = block(below: theme.company-heading-style.below)[
  == #title #theme.company-heading-style.marker
]

#let project-separator = block(..theme.project-separator-spacing)

#let tip(body) = block(..theme.tip-style)[
  *Tip:* #body
]

#let block-header(body) = block(
  ..theme.header-style,
  text(fill: theme.header-text-color, body),
)

// Shared layout for the two section colors. The marker has no visible content;
// the page background uses it to continue the last section's color to the bottom.
#let section-block(fill, body) = block(
  ..theme.section-block-style,
  fill: fill,
  [
    #metadata(fill) <section-background>
    #body
  ],
)

#let block-top-1(body) = section-block(theme.gray-section-color, body)
#let block-top-2(body) = section-block(theme.white-section-color, body)

#let block-company(name, projects) = block(
  inset: theme.experience-entry-inset,
  [
    #block()[
      #text()[
        #name
        #projects
      ]
    ]
  ]
)

#let block-project(intro, details, items, items-heading) = block(
  grid(
  columns: (5fr, 2fr), [
    #block(below: theme.project-intro-spacing)[
      #intro
    ]
    #if items != [] [
      === #items-heading
      // Reuse the skills lists' left offset without changing their spacing rules.
      #pad(left: theme.skills-list-left-margin, items)
    ]
  ],
  [
    #block(
       inset: theme.project-details-style.inset,
        [
          #align(right)[
            #table(
              ..theme.project-details-style.table,
              columns: 1fr,
              [#block(inset: theme.project-details-style.role-inset)[
                #text(fill: theme.project-details-style.label-color)[
                  #theme.details-label(details.role)
                ]
              ]],
              [#block(inset: theme.project-details-style.dates-inset)[
                #text(fill: theme.project-details-style.label-color)[
                  #theme.details-label(details.dates)
                ]
              ]],
              [#block(inset: theme.project-details-style.tech-inset)[
                #text()[
                  #theme.details-tech(details.technology.join(",\n"))
                ]
              ]]
            )
          ]
        ]
    )
  ]
  ),
)

#let block-role(role, dates, tech) = block(
  inset: theme.role-details-style.inset,
  [
    #align(right)[
      #table(
        ..theme.role-details-style.table,
        columns: 1fr,
        [#theme.details-label(role)],
        [#block(inset: theme.role-details-style.dates-inset)[
          #theme.details-label(dates)
        ]],
        project-separator,
        [#block(inset: theme.role-details-style.tech-inset)[
          #theme.details-tech(tech)
        ]]
      )
    ]
  ]
)

#let profile-title(name, role, location) = block(..theme.profile-title-style.block)[
  #text(..theme.profile-title-style.name, name)

  #block(above: theme.profile-title-style.role-spacing)[
    #text(..theme.profile-title-style.role, role)
  ]

  #block(above: theme.profile-title-style.location-spacing)[
    #text(..theme.profile-title-style.location, location)
  ]
]

#let profile-photo(path) = align(right)[
  #image(path, width: theme.profile-photo-width)
]

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

#let info-table(..args) = table(
  ..theme.info-table-style,
  ..args,
)

#let header(profile) = block-header(
  grid(
    columns: (2fr, 1fr),
    [
      #profile-title(
        profile.name,
        profile.role,
        [#profile.location.city, #strong(profile.location.country)],
      )
      #block[
        #profile.contacts.map(contact => [
          #strong(contact.label): #link(contact.url, contact.display)
        ]).join(linebreak())
      ]
    ],
    profile-photo("/" + profile.photo),
  ),
)

#let introduction-section(introduction) = [
  #block(inset: theme.heading-padding)[
    #text(..theme.section-title-text, introduction.title)
  ]
  #block-top-2(
    grid(columns: (5fr, 2fr), markdown(introduction.summary), []),
  )
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

#let project-list(items) = {
  if items.len() == 0 { return [] }
  list(..items.map(item => if type(item) == str {
    markdown(item)
  } else [
    #markdown(item.text)
    #project-list(item.at("children", default: ()))
  ]))
}

#let project-card(project, items-heading) = block-project(
  text[
    #if "title" in project [
      #block(inset: theme.project-title-inset)[
        === #project.title
      ]
    ]
    #markdown(project.summary)
  ],
  project.at("details", default: (role: "", dates: "", technology: ())),
  project-list(project.items),
  items-heading,
)

#let experience-section(experience, freelance, personal-projects) = {
  let entries = experience.entries.map(entry => (entry, experience.itemsHeading))
  entries += ((freelance, freelance.itemsHeading), (personal-projects, personal-projects.itemsHeading))
  for (index, (entry, items-heading)) in entries.enumerate() {
    let section = if calc.even(index) { block-top-2 } else { block-top-1 }
    section[
      #if index == 0 [
        #block(inset: theme.experience-heading-inset)[
          #text(..theme.section-title-text, experience.title)
        ]
      ]
      #block-company(
        h2(entry.title),
        entry.projects.map(project => project-card(project, items-heading)).join(project-separator),
      )
    ]
  }
}

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

// Each section leaves an invisible color marker (see section-block in components.typ).
// Find the last section that has started by this page, including a section carried
// over from an earlier page, and continue its color down to the paper edge.
// This changes the background without stretching content or moving page breaks.
#let section-page-background() = context {
  let current-page = here().page()
  let sections = query(<section-background>).filter(section =>
    section.location().page() <= current-page
  )
  // Color the top margin using the section that starts or continues this page.
  // A new section's marker sits just inside its top padding. Later markers belong
  // to sections farther down the page and must not change the color at the top.
  // Page 1 keeps the teal header's own background instead.
  if current-page > 1 {
    let sections-at-top = sections.filter(section => {
      let position = section.location().position()
      position.page < current-page or (
        position.y <= theme.page-top-padding + theme.section-padding.top + 0.01pt
      )
    })
    if sections-at-top.len() > 0 {
      place(top + left, rect(
        width: 100%,
        height: theme.page-top-padding,
        fill: sections-at-top.last().value,
        stroke: none,
      ))
    }
  }

  if sections.len() > 0 {
    let section = sections.last()
    let start = section.location().position()
    let start-y = if start.page == current-page { start.y } else { theme.page-top-padding }
    place(top + left, dy: start-y, rect(
      width: 100%,
      height: 100% - start-y,
      fill: section.value,
      stroke: none,
    ))
  }
}

// Draw separators only where a new section changes the background color.
// The marker is inside the section's padding, so subtract that padding to find
// the actual boundary. Skip page starts: a continuing background has no border.
#let section-page-borders() = context {
  let current-page = here().page()
  let sections = query(<section-background>)
  for (index, section) in sections.enumerate() {
    let position = section.location().position()
    let boundary-y = position.y - theme.section-padding.top
    if index > 0 and position.page == current-page and (
      boundary-y > theme.page-top-padding + 0.01pt
    ) {
      let previous = sections.at(index - 1)
      if previous.value != section.value {
        place(top + left, dy: boundary-y, line(
          length: 100%,
          stroke: theme.gray-section-border,
        ))
      }
    }
  }
}

#let cv-theme(body) = [
  #set page(
    paper: theme.page-paper,
    margin: (top: theme.page-top-padding, bottom: 0pt, x: 0pt),
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
