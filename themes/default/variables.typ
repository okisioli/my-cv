
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
