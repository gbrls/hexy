// #set text(10pt, font: "mononoki", fill: rgb("#787C99"))

#let fold-bytes(arr) = {
  let a = arr.map(x => x.at(0)).first()
  let b = arr.map(x => x.at(1))
  let c = arr.map(x => x.at(2))
  (a, b, c)
}

#let file-to-ascii-hex-chunks(fname, bytes-per-row, font) = {
  let bytes = array(read(fname, encoding: none))
  let hex = bytes.map(b => {
    let s = str(b, base: 16)
    if s.len() > 1 {
      text(s, font: font)
    } else {
      text("0" + s, font: font)
    }
  })
  let ascii = bytes.map(b => str.from-unicode(b))
  range(bytes.len())
    .zip(hex, ascii)
    .chunks(bytes-per-row)
    .map(arr => fold-bytes(arr))
}

#let hexdump(
  file,
  bytes-per-row: 16,
  column-gutter: (30pt, 20pt, 30pt),
  font: "Adwaita Mono",
  inset: 0pt,
  row-gutter: 2.5pt,
) = {
  let bs = file-to-ascii-hex-chunks(file, bytes-per-row, font)

  let lines = bs
    .map(x => x.at(0))
    .map(line => text(str(line, base: 16), font: font, weight: "bold"))
  let hex = bs.map(x => x.at(1))
  let ascii = bs
    .map(x => x.at(2))
    .map(x => text(x.join().replace(regex("[^\x21-\x7E]"), "."), font: font))
  let hex-a = hex.map(hs => hs
    .enumerate()
    .filter(x => x.first() < bytes-per-row / 2)
    .map(x => x.last()))
  let hex-b = hex.map(hs => hs
    .enumerate()
    .filter(x => x.first() >= bytes-per-row / 2)
    .map(x => x.last()))

  grid(
    columns: 4,
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    inset: inset,
    ..lines.map(grid.cell.with(x: 0)),
    ..hex-a.map(x => x.join(" ")).map(grid.cell.with(x: 1)),
    ..hex-b.map(x => x.join(" ")).map(grid.cell.with(x: 2)),
    ..ascii.map(grid.cell.with(x: 3))
  )
}
