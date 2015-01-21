if window.location.hash == \#skoly
  okresy = d3.tsv.parse ig.data.skoly, (row) ->
    row.skoly = parseFloat row.skoly
    row.lmp = parseFloat row.lmp
    row
  okresy.sort (a, b) -> a.lmp - b.lmp
  lmp = okresy.map (.lmp)
    ..unshift "lmp"

  skoly = okresy.map (.skoly)
    ..unshift "skoly"

  container = d3.select ig.containers.base
  chart = container.append \div
    ..attr \id \chart

  c3.generate do
    bindto: \#chart
    padding:
      right: 30
    data:
      color: -> \#003366
      xs:
        skoly: "lmp"
      columns: [skoly, lmp]
      type: \scatter
    axis:
      x:
        label: "Lehké mentální postižení v dětské populaci"
      y:
        label: "Podíl „segregovaných“ škol"
        padding:
          top:20
          bottom:20
    point:
      r: 8
    legend:
      show: false
    tooltip:
      format:
        value: (value, _, __, i) ->
          row = okresy[i]
          "Okres <b>#{row.okres}</b>:<br /><b>#{row.lmp} %</b> žáků s LMP, <b>#{row.skoly}</b> % segregovaných škol"
else
  romove = d3.tsv.parse ig.data.romove, (row) ->
    row.lmp = parseFloat row.lmp
    row.romu = parseFloat row.romu
    row
  romove.sort (a, b) -> a.romu - b.romu

  lmp = romove.map (.lmp)
    ..unshift "lmp"

  romu = romove.map (.romu)
    ..unshift "romu"

  container = d3.select ig.containers.base
  chart = container.append \div
    ..attr \id \chart

  c3.generate do
    bindto: \#chart
    padding:
      right: 30
    data:
      color: -> \#ab0000
      xs:
        lmp: "romu"
      columns: [lmp, romu]
      type: \scatter
    axis:
      x:
        label: "Romů na 1000 obyvatel"
      y:
        label: "Podíl žáků s LMP"
        padding:
          top:20
          bottom:20
    point:
      r: 8
    legend:
      show: false
    tooltip:
      format:
        value: (value, _, __, i) ->
          row = romove[i]
          "<b>#{row.kraj}</b> kraj:<br /><b>#{row.romu}</b> romů na 1000 obyvatel, <b>#{row.lmp} %</b> žáků s LMP"
