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
    font: 14px FontAwesome
    top: 1px
    position: relative
    left: 10px
  """

getITunesInfo: (trackName, artistName) ->
  if !trackName.match(null)
    return "<span class='fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp#{trackName} - #{artistName}</span>"
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
