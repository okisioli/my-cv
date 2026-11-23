#import "variables.typ" as theme

#let block-header(body) = block(
  ..theme.header-style,
  text(fill: theme.header-text-color, body),
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
