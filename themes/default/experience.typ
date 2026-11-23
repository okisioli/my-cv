#import "variables.typ" as theme
#import "components.typ": block-top-1, block-top-2, markdown

#let h2(title) = block(below: theme.company-heading-style.below)[
  == #title #theme.company-heading-style.marker
]

#let project-separator = block(..theme.project-separator-spacing)

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
