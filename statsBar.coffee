command: "echo $(sh ./scripts/wifi.sh)@$(osascript scripts/mail.applescript)"

refreshFrequency: 180000 # ms

location: "<span class='fontawesome'>&#xf0ac;&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp--</span>"

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./assets/colors.css">
    <div class="statsBar"></div>
  """

afterRender: (domEl) ->
    window.geolocation.getCurrentPosition (location) =>
      coords = location.position.coords
      @getLocation(coords)
      @refresh()

style: """
  right: 18px
  bottom: 2px
  height: 13
  .fontawesome
    font: 14px FontAwesome
    top: 1px
    position: relative
    left: 10px
  """

getWifiStatus: (status, netName, netIP) ->
  if status == "Wi-Fi"
    return "<span class='fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>#{netName}&nbsp-&nbsp</span><span class='white'>#{netIP}&nbsp</span>"
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='yellowbg fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>#{netIP}</span>"
  else
    return "<span class='grey fontawesome'>&nbsp&nbsp&nbsp</span><span class='white'>&nbsp--</span>"

getMailCount: (mailCount) ->
  if !mailCount.match(null)
    return "<span class='fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp#{mailCount}</span>"
  else
    return "<span class='grey fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp--</span>"

getLocation:(coords) ->
  altitudeRounded = Math.round(coords.altitude)
  @location = "<span class='fontawesome'>&#xf0ac;&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp#{coords.longitude}°, #{coords.latitude}° - #{altitudeRounded}m a.s.l</span>"

getITunesInfo: (trackName, artistName) ->
  if !trackName.match(null)
    return "<span class='fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp#{trackName} - #{artistName}</span>"
  else
    return "<span class='grey fontawesome'>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>&nbsp--</span>"

update: (output, domEl) ->

  values = output.split('@')

  netStatus = values[0].replace /^\s+|\s+$/g
  netName = values[1]
  netIP = values[2]
  mailCount = values[3]
  trackName = values[4]
  artistName = values[5]

  window.geolocation.getCurrentPosition (location) =>
    coords = location.position.coords
    @getLocation(coords)

  # create an HTML string to be displayed by the widget
  htmlString =
    "<span>&nbsp&nbsp|</span>" +
    @getMailCount(mailCount) +
    "<span>&nbsp&nbsp|</span>" +
    @getWifiStatus(netStatus, netName, netIP) +
    "<span>&nbsp&nbsp|</span>" +
    @location

  $(domEl).find('.statsBar').html(htmlString)
