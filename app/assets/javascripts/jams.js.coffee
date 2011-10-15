# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



words =[
  {
    str: "Alabama",
    time: 0.0
  },{
    str: "Alaska",
    time: 2
  },{
    str: "Arizona",
    time: 5.0
  }

]



$ () ->

  $.fn.qcard = (words) ->
    console.log 'qcard'
    qcard = this
    totalOffset = 5000 # px
    totalTime = 1000 * 60 # msec
    rate =  totalOffset  / totalTime # px/msec
    for word in words
      do (word) ->
        console.log word, word.str, word.time
        wordOffset = rate * word.time * 1000 # px/msec * sec * (msec/sec)
        speed = 400
        qcard .append("<div style='left: #{wordOffset}px' class='word'>#{word.str}</div>")

    this.bind 'qcard:start', () ->
      $(this).animate({left: "-#{totalOffset}px" }, totalTime , 'linear')
      $('#qaudio').get(0).play()

    this.bind 'qcard:stop', () ->
      $(this).stop()
      $('#qaudio').get(0).pause()

    this.bind 'qcard:restart', () ->
      $(this).trigger 'qcard:stop'
      $('#qaudio').get(0).currentTime = 0
      $(this).css({left: '0px'})
      $(this).trigger 'qcard:start'


  $('#qcard').qcard(words)

  $('[data-control]').live 'click', () ->
    selector = $(this).data('control')
    event = $(this).data('action')
    console.log selector, event
    $(selector).trigger(event)
    false




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