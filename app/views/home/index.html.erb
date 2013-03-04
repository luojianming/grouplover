<% content_for :stylesheet do %>
  <%= stylesheet_link_tag "bootstrap_and_overrides", "style", "homepage" %>
<% end %>
<% content_for :subnav do %>
  <%= render 'layouts/subnavigation' %>
<% end %>
<div class="container" id="container">
  <%= render 'users/invitation', :invitations => @invitations %>
  <!-- <input class="btn" value="点此加载" id="load" />-->
  <div id="loading_div" style="bottom: 0px;position: absolute;clear:both; width:100%;text-align:center;z-index: 1000;">
  </div>
</div>
<%= render 'users/show_foot' %>
<nav id="page-nav">
  <%= will_paginate  @invitations%>
</nav>

<script>
$('#load').click(function(){
  $.ajax({
    type: "get",
    url: "http://127.0.0.1:3000",
    success: function(data) {
      var $res = $(data).find('.item');
      $('#container').append($res).masonry('appended', $res);
    }

  })
});
</script>
<script>
 function sleep(d){
   for (var t = Date.now(); Date.now() - t <= d;);
 }
</script>
<script type="text/javascript">

$(function(){
  var $container = $('#container');
  $container.imagesLoaded(function(){
    $container.masonry({
      // options
      itemSelector : '.item',
      columnWidth : 235
    });
  });
  $container.infinitescroll({
    navSelector : '#page-nav',
    nextSelector : 'li.next_page a:first',
    itemSelector : '.item',
    loading: {
      selector: '#loading_div',
      msgText: "正在加载中...",
      finishedMsg: '没有更多页面了',
      img: '/6RMhx.gif'
    }
  },
  function(newElements){
    var $newElems = $( newElements ).css({ opacity: 0 });
    $newElems.imagesLoaded(function(){
      // show elems now they're ready
      $newElems.animate({ opacity: 1 });
      $container.masonry( 'appended', $newElems, true ); 
    });
    applied_action_process();
  });
});

jQuery(document).ajaxError(function(e,xhr,opt){
  if (xhr.status == 404) jQuery('#').remove();
  });
</script>
<script type="text/javascript">

$(document).ready(function(){
  applied_action_process();
});
</script>
<script>
	$('.members ul li').tooltip({
      selector: "a[rel=tooltip]"})
</script>
<script>
  function applied_action_process(){
    $("div.item").children(".actions").hide();
    $("div.item").mouseout(function(){
      $(this).children(".actions").hide();
    });
    $("div.item").mouseover(function(){
      $(this).children(".actions").show();
    });
  }
</script>
