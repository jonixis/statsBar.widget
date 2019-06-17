command: "echo $(sh ./statsBar.widget/scripts/wifi.sh)@$(osascript ./statsBar.widget/scripts/mail.applescript)@$(sh ./statsBar.widget/scripts/vmStatus.sh)"

refreshFrequency: 180000 # ms

location: "<span class='fontawesome'>&#xf0ac</span><span class='white'>--</span>"

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./statsBar.widget/assets/colors.css">
    <div class="statsBar"></div>
  """

afterRender: (domEl) ->
    window.geolocation.getCurrentPosition (location) =>
      coords = location.position.coords
      @getLocation(coords)
      @refresh()

style: """
  right: 10px
  bottom: 4px
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
  .ubuntu
    color: #E95420
  """

getWifiStatus: (status, netName, netIP) ->
  if status == "Wi-Fi"
    return "<span class='fontawesome'>&#xf1eb</span><span class='white'>#{netName} - </span><span class='white'>#{netIP}</span>"
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='yellowbg fontawesome'>&#xf6ff</span><span class='white'>#{netIP}</span>"
  else
    return "<span class='white fontawesome'>&#xf1eb</span><span class='white'>--</span>"

getMailCount: (mailCount) ->
  if !mailCount.match(null)
    return "<span class='fontawesome'>&#xf01c</span><span class='white'>#{mailCount}</span>"
  else
    return "<span class='white fontawesome'>&#xf01c</span><span class='white'>--</span>"

getLocation:(coords) ->
  altitudeRounded = Math.round(coords.altitude)
  @location = "<span class='fontawesome'>&#xf0ac</span><span class='white'>#{coords.longitude}°, #{coords.latitude}° - #{altitudeRounded}m a.s.l</span>"

getVmStatus: (vmStatus) ->
  if (vmStatus.match(1))
    return "<span class='fontawesomebrands ubuntu'>&#xf7df</span>"
  else
    return "<span class='fontawesomebrands white'>&#xf7df</span>"

update: (output, domEl) ->

  values = output.split('@')

  netStatus = values[0].replace /^\s+|\s+$/g
  netName = values[1]
  netIP = values[2]
  mailCount = values[3]
  vmStatus = values[4]

  window.geolocation.getCurrentPosition (location) =>
    coords = location.position.coords
    @getLocation(coords)

  # create an HTML string to be displayed by the widget
  htmlString =
    "<span>&nbsp&nbsp|</span>" +
    @getVmStatus(vmStatus) +
    "<span>&nbsp|</span>" +
    @getMailCount(mailCount) +
    "<span>&nbsp&nbsp|</span>" +
    @getWifiStatus(netStatus, netName, netIP) +
    "<span>&nbsp&nbsp|</span>" +
    @location

  $(domEl).find('.statsBar').html(htmlString)
