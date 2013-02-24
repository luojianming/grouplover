<div class="nav-menu">
  <ul class="container">
    <li class="dropdown">
      <a href="#"  class="dropdown-toggle" data-toggle="dropdown">
        <% if params[:city]==nil || params[:city].size==0%>
          全国
        <% else %>
          <%= params[:city] %>
        <% end %>
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu" id="swatch-menu">
        <%= render 'layouts/hot_cities' %>
        <li class="divider"></li>
      </ul>
    </li>

    <li class="dropdown">
      <a href="#"  class="dropdown-toggle" data-toggle="dropdown">
        <% if params[:member_counts]==nil || params[:member_counts].size==0%>
          人数不限
      <% else %>
          <%= params[:member_counts] %>
      <% end %>
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu" id="swatch-menu">
        <%= render 'layouts/member_counts' %>
        <li class="divider"></li>
      </ul>
    </li>
    <li style="margin-right:4px;"><a href="#">含有老乡的group</a></li>
    <li style="margin-right:4px;"><a href="#">高级搜索</a></li>
    <li><a href="#">全部</a></li>
  </ul>
</div><!--navbar navbar-fixed-top-->
