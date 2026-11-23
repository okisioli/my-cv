
// Extra breathing room at the top of every page (independent of section padding).
#let page-top-padding = 0.5cm

// Padding inside each gray or white section.
#let section-padding = (
  top: 0.65cm, bottom: 0.75cm,
  left: 1.5cm, right: 1.5cm
)

#let heading-padding = (
  left: 1.5cm, right: 1.5cm,
  top: 1cm, bottom: 0cm
)

#let accent-color = rgb("#125b49")
// Marker text for the two skills lists only. Replace "//" with "#", etc.
#let skills-list-marker = "#"
// Marker text for achievement lists. Change independently of the skills marker.
#let achievement-list-marker = "//"
// Shared by skills and achievement lists. Negative values move lists left.
#let skills-list-left-margin = -1.9em
#let gray-section-color = rgb(240, 240, 240)
// Approximately 1px, at 25% opacity to keep the gray/white boundaries subtle.
#let gray-section-border = 0.75pt + gray-section-color.darken(20%).transparentize(75%)
#let white-section-color = rgb(255, 255, 255)

#let page-paper = "a4"
#let cv-text = (font: "Bahnschrift", spacing: 0.35em)
#let section-title-text = (size: 1.8em, fill: accent-color)
#let experience-heading-inset = (top: 1.6em, bottom: 0.5em)
#let project-title-inset = (top: 0em)
#let skills-grid-gutter = 1.2cm
#let footer-grid-column-gutter = 1em
#let footer-contact-style = (inset: (top: 1.5em), text-size: 2em)

#let company-heading-style = (
  below: 1.25em,
  marker: text(fill: accent-color)[█],
)
#let section-rule-spacing = (above: 0.65em, below: 1.5em)
#let section-rule-line = (length: 100%, stroke: 1pt)
#let tip-style = (
  fill: rgb("#eef6ff"),
  inset: 0.8em,
  radius: 4pt,
  stroke: rgb("#b6d4fe"),
)
#let header-style = (
  // Extend the background into the top margin while keeping the content inset.
  outset: (top: page-top-padding),
  below: 1em,
  inset: (top: 0.5cm, bottom: 0.95cm, left: 1.5cm, right: 1.5cm),
  fill: accent-color,
)
#let header-text-color = rgb("#f0f0f0")
#let section-block-style = (width: 100%, above: 0em, below: 0em, inset: section-padding)
#let experience-entry-inset = (top: 0.2em, bottom: 0.5em, left: 0em, right: 0em)

#let project-intro-spacing = 1.75em
#let project-details-style = (
  inset: (top: 0em, bottom: 0.5em, left: 1.75em, right: 0.75em),
  table: (stroke: 0em, inset: 0em, row-gutter: 0.6em),
  role-inset: (bottom: 0em),
  dates-inset: (bottom: 1em),
  tech-inset: (top: 0em),
  label-color: accent-color,
)
#let role-details-style = (
  inset: (top: 0.5em, bottom: 0.5em, left: 1.75em, right: 0.75em),
  table: (stroke: 0em, inset: 0em, row-gutter: 0.75em),
  dates-inset: (bottom: 0.5em),
  tech-inset: (top: 0.5em),
)
#let details-label = strong
#let details-tech = emph

#let profile-title-style = (
  block: (below: 2em, inset: (top: 0.5em)),
  name: (size: 36pt, weight: "light"),
  role: (size: 14pt, style: "italic"),
  role-spacing: 2.25em,
  location: (size: 12pt),
  location-spacing: 0.75em,
)
#let profile-photo-width = 4.5cm
#let skills-column-style = (
  heading-block: (below: 1.8em, inset: (top: 0.5em, left: -0.125em)),
  heading-text: (size: 1.3em, fill: accent-color),
  list-inset: (left: skills-list-left-margin, top: 0em),
  body-size: 1.1em,
)
#let info-table-style = (inset: 0pt, gutter: 1em, column-gutter: 1em, stroke: 0pt)

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
        position.y <= page-top-padding + section-padding.top + 0.01pt
      )
    })
    if sections-at-top.len() > 0 {
      place(top + left, rect(
        width: 100%,
        height: page-top-padding,
        fill: sections-at-top.last().value,
        stroke: none,
      ))
    }
  }

  if sections.len() > 0 {
    let section = sections.last()
    let start = section.location().position()
    let start-y = if start.page == current-page { start.y } else { page-top-padding }
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
    let boundary-y = position.y - section-padding.top
    if index > 0 and position.page == current-page and (
      boundary-y > page-top-padding + 0.01pt
    ) {
      let previous = sections.at(index - 1)
      if previous.value != section.value {
        place(top + left, dy: boundary-y, line(
          length: 100%,
          stroke: gray-section-border,
        ))
      }
    }
  }
}

// Shared marker appearance for skills and achievements. Scaling is visual only,
// so the heavier, larger characters do not increase line spacing.
#let accent-list-marker(symbol) = scale(110%, reflow: false, text(
  weight: "black",
  fill: accent-color,
  // Keep the marker heavy even when Arial falls back to its bold face.
  stroke: 0.12pt + accent-color,
  symbol,
))

#let cv-theme(body) = [
  #set page(
    paper: page-paper,
    margin: (top: page-top-padding, bottom: 0pt, x: 0pt),
    background: section-page-background(),
    foreground: section-page-borders(),
  )
  #set text(size: 9.7pt, ..cv-text)
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

  #set list(marker: accent-list-marker(achievement-list-marker))

  #body
]
