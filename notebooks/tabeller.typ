#set page(flipped: true, background: none)
#set text(size: 24pt)
#import "@local/num_to_str:1.0.0": num_to_str
#let tabell(fil) = {
  let data = csv(fil)

  table(
    columns: 4,
    inset: 9pt,
    table.cell(colspan: 4, align: center)[Truth table for #data.at(0).at(0)],
    [], ..data.at(0).slice(1),
    ..for line in data.slice(1) {
      for (i, s) in line.enumerate() {
        if s.at(0, default: "1") == "0" {
          line.at(i) = num_to_str(s, digits: 4)
        }
      }
      line
    }
  )
  pagebreak(weak: true)
}

#tabell("tt_b")
#tabell("tt_c")
#tabell("tt_all")
