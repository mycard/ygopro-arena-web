# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require jquery.markitup
//= require jquery.markitup.set
//= require jquery.captcha
//= require jquery-ui

localStorage = {} if Storage?
localStorage['stream'] = {}
getstream = (data) ->
  for key, value of data
    for item in value
      localStorage['stream'][key] ||= {}
      localStorage['stream'][key][item.id] = item
  for post in data.posts
    post_element = $('<div />',
      class: 'post'
      id: "post" + post.id
    )
    post_element.append $('<img />',
      src: '/users/' + post.user_id + '.png?size=small'
    )
    post_element.append $('<span />',
      class: 'post[user]'
      text: localStorage['stream']['users'][post.user_id].name
    )
    post_element.append $('<span />',
      class: 'post[content]'
      text: post.content
    )
    if $('#topic' + post.topic_id).length == 0
      if $('#topics .topic').length >= 5
        $('#topics .topic').last().remove()

      $('#topics').prepend $('<div />',
        id: 'topic' + post.topic_id
        class: 'topic'
      )
      $('#topic' + post.topic_id).append $('<span />',
        class: "topic[name]"
        text: localStorage['stream']['topics'][post.topic_id].name
      )
      $('#topic' + post.topic_id).append $('<span />',
        class: "topic[board]"
        text: localStorage['stream']['boards'][localStorage['stream']['topics'][post.topic_id].category_id].name
        href: '/boards/' + localStorage['stream']['topics'][post.topic_id].category_id
      )
      $('#topic' + post.topic_id).append post_element
    else
      post_element.addClass('last')
      if $('#post' + post.id).length == 0
        if $('#topic' + post.topic_id).length == 1
          $('#topic' + post.topic_id + ' .post').addClass('first')
          $('#topic' + post.topic_id).append post_element
        else
          $('#topic' + post.topic_id + ' .post').last().html post_element
       else
          $('#post' + post.id).html post_element

$.get('/stream.json?pull=2012-06-10 15:14:44 +0800', getstream)

