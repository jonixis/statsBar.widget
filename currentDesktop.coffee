command: "echo $(x=$(/usr/local/bin/chunkc tiling::query -d id);echo $(/usr/local/bin/chunkc tiling::query -D $(/usr/local/bin/chunkc tiling::query -m id))\",$x\")"

refreshFrequency: 1000

iconTerminal: "&#xf120"
iconCode: "&#xf121"
iconFireFox: "&#xf269"
iconFolder: "&#xf07b"
iconMusic: "&#xf144"
iconMail: "&#xf0e0"

render: (output) ->
  values = output.split(',')
  spaces = values[0].split(' ')

  htmlString = """
    <div class="currentDesktop-container" data-count="#{spaces.length}">
      <ul>
  """

  for i in [0..spaces.length - 1]
    icon = ""
    switch spaces[i]
        when '1'
          icon = @iconTerminal
          cssClass = "fontawesome"
        when '2'
          icon = @iconCode
          cssClass = "fontawesome"
        when '3'
          icon = @iconFireFox
          cssClass = "fontawesomebrands"
        when '4'
          icon = @iconFolder
          cssClass = "fontawesome"
        when '5'
          icon = @iconMusic
          cssClass = "fontawesome"
        when '6'
          icon = @iconMail
          cssClass = "fontawesome"
        else
          icon = @iconTerminal
          cssClass = "fontawesome"
    htmlString += "<li><span id=\"desktop#{spaces[i]}\" class='#{cssClass}'>#{icon}</span></li>"

  htmlString += """
      <ul>
    </div>
  """

style: """
  left: 0px
  bottom: 4px
  position: absolute
  font-family: 'Font Awesome 5 Free'
  font-size: 14px

  ul
    list-style: none
    margin: 0 0 0 0
    padding: 0

  li
    display: inline
    margin: 0px 10px

  span.active
    color: #80bc4f

  .fontawesomebrands
    font-family: 'Font Awesome 5 Brands'
    font-size: 14px
    top: 1px
    position: relative
    left: 10px

  .fontawesome
    font-family: 'Font Awesome 5 Free'
    font-size: 14px
    top: 1px
    position: relative
    left: 10px
"""

update: (output, domEl) ->
  values = output.split(',')
  spaces = values[0].split(' ')
  space = values[1]

  htmlString = ""
  for i in [0..spaces.length - 1]
    icon = ""
    switch spaces[i]
        when '1'
          icon = @iconTerminal
          cssClass = "fontawesome"
        when '2'
          icon = @iconCode
          cssClass = "fontawesome"
        when '3'
          icon = @iconFireFox
          cssClass = "fontawesomebrands"
        when '4'
          icon = @iconFolder
          cssClass = "fontawesome"
        when '5'
          icon = @iconMusic
          cssClass = "fontawesome"
        when '6'
          icon = @iconMail
          cssClass = "fontawesome"
        else
          icon = @iconTerminal
          cssClass = "fontawesome"
    htmlString += "<li><span id=\"desktop#{spaces[i]}\" class='#{cssClass}'>#{icon}</span></li>"

  if ($(domEl).find('.currentDesktop-container').attr('data-count') != spaces.length.toString())
     $(domEl).find('.currentDesktop-container').attr('data-count', "#{spaces.length}")
     $(domEl).find('ul').html(htmlString)
     $(domEl).find("span#desktop#{space}").addClass('active')
  else
    $(domEl).find('span.active').removeClass('active')
    $(domEl).find("span#desktop#{space}").addClass('active')
