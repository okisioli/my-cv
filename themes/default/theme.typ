#import "components.typ": cv-theme, header, introduction-section, skills-section, experience-section, footer

#let render(cv) = cv-theme[
  #header(cv.profile)
  #introduction-section(cv.introduction)
  #skills-section(cv.skills)
  #experience-section(cv.experience, cv.freelance, cv.personalProjects)
  #footer(cv.languages, cv.education, cv.footerContact)
]
