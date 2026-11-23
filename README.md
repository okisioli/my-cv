# Hello, I'm Oliver, and this is my CV 👋

If you're seeing this, it's likely that I'm actively or passively looking for new opportunities.
You can find more information about me, my coding experience, and personal projects in this resume.

```csharp 
📞 +4219░▒░▓▓▒░▓
📩 oliv▓▒▓░▒▒░@gmail.com
🤔 "maybe not a good idea to put this in a public repo"
```

If you're still reading, please continue. You can [view the CV in its raw form right here on GitHub](https://github.com/okisioli/my-cv/blob/main/cv.json).
If you prefer a more traditional PDF-like experience, there's two ways to get it up and running.

## Build it yourself (recommended) 🛠️

### Install Typst

You'll need [Typst](https://typst.app/) to compile the document for a better reading experience.
Follow the [installation instructions](https://typst.app/open-source/#download/) to get Typst up and running on your platform.

### Compile the CV

After you (obviously) checkout the repository, run the following command in its root:

```bash
typst compile cv.typ cv-light.pdf
```

*NOTE*: `typst` has to be on your PATH already. Your package manager probably took care of that, but if not, try opening a new terminal session or signing out from your user profile.

If the default CV is too bright, you can compile it with the lights off.

```bash
typst compile --input mode=dark cv.typ cv-dark.pdf
```

## Download the PDF 📦

For your convenience (and HR), an up-to-date version can be downloaded below:

- [Light Mode](https://okisioli.github.io/my-cv/cv-light.pdf)
- [Dark Mode](https://okisioli.github.io/my-cv/cv-dark.pdf)
