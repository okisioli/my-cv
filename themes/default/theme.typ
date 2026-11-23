#import "components.typ": cv-theme
#import "header.typ": header
#import "introduction.typ": introduction-section
#import "skills.typ": skills-section
#import "experience.typ": experience-section
#import "footer.typ": footer

#let render(cv) = cv-theme[
  #header(cv.profile)
  #introduction-section(cv.introduction)
  #skills-section(cv.skills)
  #experience-section(cv.experience, cv.freelance, cv.personalProjects)
  #footer(cv.languages, cv.education, cv.footerContact)
]
