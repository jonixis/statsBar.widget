command: "echo $(sh ./statsBar.widget/scripts/wifi.sh)@$(osascript ./statsBar.widget/scripts/mail.applescript)@$(sh ./statsBar.widget/scripts/vmStatus.sh)"

targetRefreshFrequency: 60000 # in ms

refreshFrequency: @targetRefreshFrequency

location: "<span class='fontawesome'>&#xf0ac</span><span class='white'>--</span>"

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./statsBar.widget/assets/colors.css">
    <div class="statsBar"></div>
  """

style: """
  right: 10px
  top: 2px
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

getVmStatus: (vmStatus) ->
  if (vmStatus.match(1))
    return "<span class='fontawesomebrands ubuntu'>&#xf7df</span>"
  else
    return "<span class='fontawesomebrands white'>&#xf7df</span>"

getTime: () ->
  date = new Date
  @syncWithTime(date)

  hours = date.getHours()
  minutes = date.getMinutes()
  minutes = if minutes < 10 then '0'+minutes else minutes

  return "<span class='fontawesome'>&#xf017</span><span class='white'>#{hours}:#{minutes}</span>"

syncWithTime: (date) ->
  seconds = date.getSeconds()
  nextFullMinute = 60 - seconds

  if (nextFullMinute > 1 && nextFullMinute < 59)
    @refreshFrequency = nextFullMinute * 1000
  else if (@refreshFrequency != @targetRefreshFrequency)
    @refreshFrequency = @targetRefreshFrequency

updateLocation: () ->
  window.geolocation.getCurrentPosition (location) =>
    coords = location.position.coords
    altitudeRounded = Math.round(coords.altitude)
    @location = "<span class='fontawesome'>&#xf0ac</span><span class='white'>#{altitudeRounded}m a.s.l</span>"

update: (output, domEl) ->

  values = output.split('@')

  netStatus = values[0].replace /^\s+|\s+$/g
  netName = values[1]
  netIP = values[2]
  mailCount = values[3]
  vmStatus = values[4]

  @updateLocation()

  # create an HTML string to be displayed by the widget
  htmlString =
    "<span>&nbsp&nbsp|</span>" +
    @getVmStatus(vmStatus) +
    "<span>&nbsp|</span>" +
    @getMailCount(mailCount) +
    "<span>&nbsp&nbsp|</span>" +
    @getWifiStatus(netStatus, netName, netIP) +
    "<span>&nbsp&nbsp|</span>" +
    @location +
    "<span>&nbsp&nbsp|</span>" +
    @getTime()

  $(domEl).find('.statsBar').html(htmlString)
