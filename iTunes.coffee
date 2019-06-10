command: "echo $(osascript scripts/itunes.applescript)"

refreshFrequency: 8000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./assets/colors.css">
    <div class="iTunes"></div>
  """

style: """
  width: 100%
  text-align: center
  bottom: 2px
  height: 13
  .fontawesome
    font-family: 'Font Awesome 5 Free'
    font-size: 14px
    top: 1px
    position: relative
    left: 10px
    margin-right: 15px
  .fontawesomebrands
    font-family: 'Font Awesome 5 Brands'
    font-size: 14px
    top: 1px
    position: relative
    left: 10px
    margin-right: 15px
  """

getITunesInfo: (trackName, artistName) ->
  if !trackName.match(null)
    return "<span class='fontawesomebrands'>&#xf3b5</span><span class='white'>#{trackName} - #{artistName}</span>"
  else
    return ""

update: (output, domEl) ->

  values = output.split('@')

  trackName = values[0]
  artistName = values[1]


  # create an HTML string to be displayed by the widget
  htmlString =
    @getITunesInfo(trackName, artistName)

  $(domEl).find('.iTunes').html(htmlString)
