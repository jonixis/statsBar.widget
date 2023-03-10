command: "echo $(osascript statsBar.widget/scripts/music.applescript)"

refreshFrequency: 8000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./assets/colors.css">
    <div class="music"></div>
  """

style: """
  width: 100%
  top: 6px
  left: 290px;
  height: 13
  .fontawesome
    font-family: 'Font Awesome 6 Free'
    font-size: 14px
    top: 1px
    position: relative
    left: 10px
    margin-right: 15px
  .fontawesomebrands
    font-family: 'Font Awesome 6 Brands'
    font-size: 14px
    top: 1px
    position: relative
    left: 10px
    margin-right: 15px
  """

getMusicInfo: (trackName, artistName) ->
  if !trackName.match(null)
    if (artistName.length <= 1)
      trackString = trackName
    else
      trackString = trackName + " - " + artistName
    return "<span>&nbsp&nbsp|</span><span class='fontawesomebrands'>&#xf3b5</span><span class='white'>#{trackString}</span>"
  else
    return ""

update: (output, domEl) ->

  values = output.split('@')

  trackName = values[0]
  artistName = values[1]


  # create an HTML string to be displayed by the widget
  htmlString =
    @getMusicInfo(trackName, artistName)

  $(domEl).find('.music').html(htmlString)
