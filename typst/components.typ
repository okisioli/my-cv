#import "theme.typ" as theme

#let h2(title) = block(below: theme.company-heading-style.below)[
  == #title #theme.company-heading-style.marker
]

#let section-rule = block(..theme.section-rule-spacing)
[
  #line(..theme.section-rule-line)
]

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

#let block-personal(name, projects) = block(
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

// Employment is the default; use false for freelance or personal project lists.
#let block-project(intro, role, dates, tech, achievements, is-employment: true) = block(
  grid(
  columns: (5fr, 2fr), [
    #block(below: theme.project-intro-spacing)[
      #intro
    ]
    #if achievements != [] [
      === #if is-employment [Key achievements] else [Some of the projects]
      // Reuse the skills lists' left offset without changing their spacing rules.
      #pad(left: theme.skills-list-left-margin, achievements)
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
                  #theme.details-label(role)
                ]
              ]],
              [#block(inset: theme.project-details-style.dates-inset)[
                #text(fill: theme.project-details-style.label-color)[
                  #theme.details-label(dates)
                ]
              ]],
              [#block(inset: theme.project-details-style.tech-inset)[
                #text()[
                  #theme.details-tech(tech)
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
        section-rule,
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
  #set list(marker: theme.accent-list-marker(theme.skills-list-marker))
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
