# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$.fn.qcard = (words, offset) ->
  qcard = this
  stretchFactor = 1.5
  totalOffset = 14722 * stretchFactor # px
  # $('#boothheader > div:last').css('left') --  14600
  # $('#boothheader > div:last').width()           122

  totalTime = 1000 * 73 # msec
  rate =  totalOffset  / totalTime # px/msec


  this.html('')

  factor = 1000 * 0.2

  for word in words
    do (word) ->
      console.log word, word.text, word.time
      wordOffset = factor * stretchFactor * (word.time.begin + 4.5) # px/msec * sec * (msec/sec)
      length = ( word.time.end - word.time.begin ) * factor
      console.log('offset, length', wordOffset, length)

      qcard.append("<div style='left: #{wordOffset}px; min-width: #{length}px' class='word #{word.text}'>#{word.text.replace(/\s/g, '&nbsp;')}</div>")

  $('.Florida').css({minWidth: '251px'}); # what the fuck?

  this.unbind('qcard:start')
  this.unbind('qcard:stop')
  this.unbind('qcard:reset')
  this.unbind('qcard:restart')

  this.bind 'qcard:start', () ->
    console.log 'qcard starting'
    $(this).animate({left: "-#{totalOffset}px" }, totalTime , 'linear')
    $("#fader").show()
    $("#fader_fader").show()
    setTimeout( () ->
      console.log 'starting audio'
      $('#qaudio').get(0).play()
    ,3000)


    $('[data-action="qcard:start"]').hide()
    $('[data-action="qcard:stop"]').show()

  this.bind 'qcard:stop', () ->
    console.log 'qcard stopping'
    $(this).stop()
    $('#qaudio').get(0).pause()

    $('[data-action="qcard:stop"]').hide()
    $('[data-action="qcard:start"]').show()

  this.bind 'qcard:reset', () ->
    console.log 'qcard resetting'
    $('#qaudio').get(0).currentTime = 0
    $(this).stop().css({left: '0px'})

  this.bind 'qcard:restart', () ->
    console.log 'qcard restarting'
    $(this).trigger 'qcard:stop'
    $('#qaudio').get(0).currentTime = 0
    $(this).css({left: '0px'})
    $(this).trigger 'qcard:start'


$ () ->

  $('[data-control]').live 'click', () ->
    selector = $(this).data('control')
    event = $(this).data('action')
    console.log selector, event
    $(selector).trigger(event)
    false

  $("#record_blocker").live 'click', () ->
#    alert('Start Q first')
    $("#boothheader").css({color: 'yellow'})
    setTimeout(() ->
      $("#boothheader").css({color: 'white'})
    , 200)



window.Timer = (callback, timeout) ->
  timerId
  remaining = timeout

  this.pause = () ->
    clearTimeout(timerId)
    remaining -= new Date() - start;

  this.resume = () ->
    start = new Date()
    timerId = setTimeout(callback, remaining)

  this.resume()






#Alabama	Alaska	Arizona	Arkansas
#California	Colorado	Connecticut	Delaware
#Florida	Georgia	Hawaii	Idaho
#Illinois	Indiana	Iowa	Kansas
#Kentucky	Louisiana	Maine	Maryland
#Massachusetts	Michigan	Minnesota	Mississippi
#Missouri	Montana	Nebraska	Nevada
#New Hampshire	New Jersey	New Mexico	New York
#North Carolina	North Dakota	Ohio	Oklahoma
#Oregon	Pennsylvania	Rhode Island	South Carolina
#South Dakota	Tennessee	Texas	Utah
#Vermont	Virginia	Washington	West Virginia
#Wisconsin	Wyoming