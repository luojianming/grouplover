	<div class="logup-top">
		<p>等待就是浪费青春</p>
		<div class="logo">校园爱情</div>
	</div>
	
	<div class="logup-main container">
	 <div class="row">
	  <div class="span9">
		<div class="hero-unit hero-unit-bg">  
      <%= simple_form_for(resource, :as => resource_name, :url => registration_path(resource_name), :html => {:class => 'form-horizontal' }) do |f| %>
        <legend>注册<span class="pull-right" style="font-size:14px">有帐号了？<%= link_to "登录", new_session_path(resource_name) %></span></legend>
          <%= f.input :name, :label => "姓名", :required => true, :autofocus => true %> 
          <%= f.input :email, :label => "邮箱", :required => true, :hint => false %> 
          <%= f.input :password, :required => true, :label => "密码" %>
          <%= f.input :password_confirmation, :required => true, :label => "密码确认" %>
          <%= f.button :submit %>
       <% end %>
     </div>   
    </div> <!-- span9 -->
  <div class="span3" style="margin-top:60px;">
		  <span style="font-size:21px;">第三方帐号登录</span> 
      <%= link_to image_tag("renrenlogin_mid.png"), omniauth_authorize_path(resource_name, "weibo")%>
      <%= link_to image_tag("weibologin_mid.png"), omniauth_authorize_path(resource_name, "weibo") %>
  </div>
 </div>  <!--row -->    
</div>
	
	<div class="logup-footer">
	</div>
