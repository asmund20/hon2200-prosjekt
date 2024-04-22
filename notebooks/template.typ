//TODO: make abstract-function


// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: "", authors: (), date: datetime.today().display("[day].[month].[year]"), language: "en", include_outline: false, abstract: none, heading_numbering: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Source Sans Pro", lang: language)
  show figure.where(kind: table): set figure.caption(position: top) 

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, strong(author))),
    ),
  )

  set par(justify: true)

  if abstract != none {
    align(center)[
      #block(width: 80%, [#text(weight: 700, 1.1em, "Abstract")\ #abstract])
    ]
  }

  if include_outline [
    #outline(indent: auto)
  ]

  set heading(numbering: heading_numbering)

  // Main body.
  body

}

// A function that returns a string with exactly the desired
// number of digits, even if it ends in zeros
// digits is the number of digits after the decimal point.
// Handles anything that can be turned into a float by
// the float constructor.
#let num_to_str(num, digits: 0) = {
  num = str(calc.round(float(num), digits: digits))

  // if digits <= 0, calc.round has the desired behaviour
  if digits <= 0 {
    return num
  }

  // here, desired digits will be strictly positive.
  // therefore, the string should contain a decimal point.
  // If it does not, the number is whole and it should be
  // concatinated at the end.
  if not num.contains(".") {
    num += "."
  }

  let i = num.position(".")

  // while the number of digits is less than the desired number,
  // concatenate a zero to the end.
  while num.slice(i+1).len() < digits {
    num += "0"
  }

  return num
}