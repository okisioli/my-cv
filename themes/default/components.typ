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

#let tip(body) = block(..theme.tip-style)[
  *Tip:* #body
]

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

#let block-top-1(body) = section-block(theme.alternate-section-color, body)
#let block-top-2(body) = section-block(theme.section-color, body)

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
          stroke: theme.section-border,
        ))
      }
    }
  }
}
