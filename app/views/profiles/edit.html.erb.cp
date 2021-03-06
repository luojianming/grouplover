<% content_for :stylesheet do %>
  <%= stylesheet_link_tag "bootstrap_and_overrides", "style", "jasny-bootstrap.min" %>
<% end %>
 <div class="container">
 	<div class="clearfix">
    <div class="row main">
      <div class="span3 sidenav">
      	  <!-- <div class="headphoto">
            	<img src="img/secure.gravatar.com.jpg"/>
                <span class="pull-left">我的头像</span>
                <span class="pull-right"><a href="#">换一张</a></span>
                
           </div>        -->
           
           <div class="fileupload fileupload-new" data-provides="fileupload">
                <div class="fileupload-new thumbnail" style="width: 200px; height: 200px;"><%= image_tag("secure.gravatar.com.jpg") %></div>
                <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 200px; line-height: 20px;"></div>
                <div>
                	<span class="btn btn-file"><span class="fileupload-new">上传头像</span><span class="fileupload-exists">换一张</span><input type="file" /></span>
                    <a href="#" class="btn fileupload-exists" data-dismiss="fileupload">删除</a>
                    
                </div>
           </div>
      	             
           <div>
      		 <ul>
                <li class="active"><a href="#profile" onClick="changeSubPage(1)"><i class="icon icon-print"></i>资料</a></li>
                <li><a href="#notification"  onClick="changeSubPage(2)"><i class="icon icon-star"></i>账户设置</a></li>
                <li><a href="#setting" onClick="changeSubPage(3)"><i class="icon icon-bell"></i>通知</a></li>                
            </ul>
           </div>
      </div>
      
      <div class="span9 profile-style" id="profile">
        <% if @profile.errors.any? %>
          <div class="alert-error">
            <ul>
              <%@profile.errors.full_messages.each do |msg| %>
                <li><%= msg %></li>
              <% end %>

            </ul>
          </div>
        <% end %>
    		<div class="hero-unit hero-unit-bg">  
          <%= simple_form_for @profile, :url => user_profiles_path(current_user), :html => {:class => "form-horizontal"} do |f| %> 
            <legend>基本资料<a class="pull-right" style="font-size:15px;color:#3FF;" onClick=""><i class="icon-edit"></i>编辑</a></legend>	
            <%= f.input :birthday, :label => "生日" %>
            <%= f.input :hometown, :label => "家乡" %>
            <%= f.input :school, :label => "学校" %>
            <div class="control-group">
              <div class="controls">							
                <button type="submit" class="btn">保存</button>
						  </div>
					  </div>
   				 <% end %>
                 
        	</div>
            
            <div class="hero-unit" style="background-color:#CFF">
            	<form class="form-horizontal"> 
                  	 <legend>兴趣爱好</legend>
                     <div class="control-group">
   					 	<label class="control-label">擅长的乐器</label>
                        <div class="controls">
    					 	<input type="text" placeholder="your name">
                        </div>
                     </div>
                     
                     <div class="control-group">
   					 	<label class="control-label">喜欢的书籍</label>
                        <div class="controls">
    					 	<input type="text" placeholder="your name">
                        </div>
                     </div>
                     
                     <div class="control-group">
   					 	<label class="control-label">喜欢的运动</label>
                        <div class="controls">
    					 	<input type="text" placeholder="your name">
                        </div>
                     </div>
                     					 
                     <div class="control-group">
   					 	<label class="control-label">喜欢的音乐</label>
                        <div class="controls">
    					 	<input type="text" placeholder="your name">
                        </div>
                     </div>
                     <div class="control-group">
   					 	<label class="control-label">喜欢的电影</label>
                        <div class="controls">
    					 	<input type="text" placeholder="sex">
                        </div>
                     </div>
					 <div class="control-group">
   					 	<label class="control-label">喜欢的动漫</label>
                        <div class="controls">
    					 	<input type="text" placeholder="hometown">
                        </div>
                     </div>
					 <div class="control-group">
   					 	<label class="control-label">玩的游戏</label>
                        <div class="controls">
    					 	<input type="text" placeholder="school">
                        </div>
                     </div>

            		 <div class="control-group">
						<div class="controls">							
						<button type="submit" class="btn">保存</button>
						</div>
					 </div>
                </form>
            </div>
            
            <div class="hero-unit" style="background-color:#FF6">
            	<form class="form-horizontal"> 
                  	 <legend>标签</legend>
                     <div class="control-group">
   					 	<label class="control-label">擅长的乐器</label>
                        <div class="controls">
    					 	<input type="text" placeholder="your name">
                        </div>
                     </div>
                     
                </form>
            </div>
            
            <div class="hero-unit" style="background-color:#FCC">
            	<form class="form-horizontal"> 
                  	 <legend>联系方式</legend>
                     <div class="control-group">
   					 	<label class="control-label">电话</label>
                        <div class="controls">
    					 	<input type="text" placeholder="Telephone">
                        </div>
                     </div>
                     
                     <div class="control-group">
   					 	<label class="control-label">MSN</label>
                        <div class="controls">
    					 	<input type="text" placeholder="MSN">
                        </div>
                     </div>
                     
                     <div class="control-group">
   					 	<label class="control-label">QQ</label>
                        <div class="controls">
    					 	<input type="text" placeholder="QQ">
                        </div>
                     </div>
                     					 
                     <div class="control-group">
   					 	<label class="control-label">Email</label>
                        <div class="controls">
    					 	<input type="text" placeholder="Email">
                        </div>
                     </div>
                 
            		 <div class="control-group">
						<div class="controls">							
						<button type="submit" class="btn">保存</button>
						</div>
					 </div>
                </form>
           </div>
        	<!--<div>
        		学校信息
        	</div>
        	<div>
        		兴趣爱好
        	</div>
        	<div class="hero-unit">
        		联系方式
        	</div>-->
      </div><!--#profile-->
      
      <div class="span9 setting-style" id="setting" style="display:none">
      	<div class="hero-unit" style="background-color:#CCCCCC">
      		<form>
    			<legend>账户设置</legend>
    			<label>Email</label>
    			<input type="text" placeholder="Email">
                <label>旧密码</label>
    			<input type="text" placeholder="Current password">
                <label>新密码</label>
    			<input type="text" placeholder="New password">
                <label>新密码确认</label>
    			<input type="text" placeholder="New password">
    			<span class="help-block"></span>				
    			<button type="submit" class="btn">保存更改</button>
    		</form>
         </div>
      </div>
      
      <div class="span9 notification-style" id="notification" style="display:none">
      	 <div class="hero-unit hero-unit-bg">
         	<h3>通知设置</h3>
            <label class="checkbox">
			<input type="checkbox" value="">
				打开邮件提醒功能
			</label>
            <h4>邮件通知我当...</h4>
      		<label class="checkbox">
			<input type="checkbox" value="">
				有人关注了你
			</label>          
      		<label class="checkbox">
			<input type="checkbox" value="">
				有人给你留言了
			</label>
            
            <label class="checkbox">
			<input type="checkbox" value="">
				有人向你的group发出邀请了
			</label>
            
             <label class="checkbox">
			<input type="checkbox" value="">
				有人接受了你的group邀请
			</label>
            
            <label class="checkbox">
			<input type="checkbox" value="">
				有人给了你新的评价
			</label>
            
            <label class="checkbox">
			<input type="checkbox" value="">
				有人给了你新的评价
			</label>
            <span class="help-block"></span>				
    		<button type="submit" class="btn">保存更改</button>
        </div>
      </div>
      
    </div>
  </div>
 </div>


<script type="text/javascript">
	function changeSubPage(i){
		$("#profile").css("display","none");
		$("#notification").css("display","none");
		$("#setting").css("display","none");
		if (i == 1){
			$("#profile").css("display","block");
		}else if(i == 2){
			$("#setting").css("display","block");
		}else{
			$("#notification").css("display","block");
		}
	}

</script>
