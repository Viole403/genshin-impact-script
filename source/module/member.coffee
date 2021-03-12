class MemberX

  map: {}

  constructor: -> $.on 'f12', @scan

  checkCharacterByPosition: (n) ->

    [pointStart, pointEnd] = @getRange n

    for name, char of Character.data

      unless char.color
        continue

      point = $.findColor char.color, pointStart, pointEnd
      unless point[0] * point[1] > 0
        continue

      return name

    return ''

  getRange: (n) ->

    start = client.point [
      90
      9 * (n + 1)
    ]

    end = client.point [
      96
      9 * (n + 2)
    ]

    return [start, end]

  scan: ->

    for n in [1, 2, 3, 4]
      name = @checkCharacterByPosition n
      @map[n] = name
      hud.render n, name

    skillTimer.reset()

    unless player.current
      $.press '1'
      @toggle 1
    else @toggle player.current

  toggle: (n) ->
    player.current = n
    player.name = @map[n]

# execute
member = new MemberX()