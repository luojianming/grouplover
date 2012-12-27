<% content_for :stylesheet do %>
  <%= stylesheet_link_tag "bootstrap_and_overrides", "style", "homepage" %>
<% end %>
<% content_for :subnav do %>
  <%= render 'layouts/subnavigation' %>
<% end %>
   <div class="container" id="container">
  		<div class="item" onMouseOver="display_actions()">
           <div class="actions" id="act">
           		  <a class="btn favor_link" href="#">
                	<i class="icon-thumbs-up"></i>
                	<span>赞！</span>
                </a>

                <a class="btn join_link" href="#">
                	<i class="icon-heart"></i>
                	<span>参与</span>
                </a>
            </div>        	
            <div class="box-photo"><%= image_tag("photo/2.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    <a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic3.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                </ul>
           </div>     
        </div>

        <div class="item">        	
            <div class="box-photo"><%= image_tag("photo/2.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/3.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/11.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item" onMouseOver="display_actions()">
           <div class="actions" id="act">
           		<a class="btn favor_link" href="#">
                	<i class="icon-thumbs-up"></i>
                	<span>赞！</span>
                </a>
                
                <a class="btn join_link" href="#">
                	<i class="icon-heart"></i>
                	<span>参与</span>
                </a>
            </div>        	
            <div class="box-photo"><%= image_tag("photo/8.jpg") %></div>
            <div class="activity_info"><span>周末下午清华园三国杀</span></div>
            <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
            <div class="members">
              <ul style="margin-left:5px">
                <li>
                <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                <a href="#">清华大学 杨过 湖南</a>
                </li>
                <li>
                <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                <a href="#">清华大学 杨过 湖南</a>
                </li>
              </ul>
            </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/8.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/3.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/2.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item" onMouseOver="display_actions()">
           <div class="actions" id="act">
           		<a class="btn favor_link" href="#">
                	<i class="icon-thumbs-up"></i>
                	<span>赞！</span>
                </a>
                
                <a class="btn join_link" href="#">
                	<i class="icon-heart"></i>
                	<span>参与</span>
                </a>
            </div>        	
           <div class="box-photo"><%= image_tag("photo/11.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
             <ul style="margin-left:5px">
               <li>
               <a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
               <a href="#">北京大学 小龙女 四川</a>
               </li>
               <li>
               <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
               <a href="#">清华大学 杨过 湖南</a>
               </li>
             </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/2.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/3.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/9.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        <div class="item" onMouseOver="display_actions()">
           <div class="actions" id="act">
           		<a class="btn favor_link" href="#">
                	<i class="icon-thumbs-up"></i>
                	<span>赞！</span>
                </a>
                
                <a class="btn join_link" href="#">
                	<i class="icon-heart"></i>
                	<span>参与</span>
                </a>
            </div>        	
           <div class="box-photo"><%= image_tag("photo/3.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/2.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/8.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>     
        </div>
        
        <div class="item">        	
           <div class="box-photo"><%= image_tag("photo/9.jpg") %></div>
           <div class="activity_info"><span>周末下午清华园三国杀</span></div>
           <div class="activity_description"><span>等待就是浪费青春，快加入我们吧，让我们尽情挥霍</span></div>
           <div class="members">
           		<ul style="margin-left:5px">
                	<li>
                    	<a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    	<a href="#" id="2" rel="tooltip" class="pull-left" data-placement="left"  title="可爱 温柔 开朗"><%= image_tag("pic2.jpg") %></a>
                        <a href="#">北京大学 小龙女 四川</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                    <li>
                    <a href="#" id="1" rel="tooltip" data-placement="left"  title="聪明 帅气 开朗" class="pull-left"><%= image_tag("pic4.jpg") %></a>
                        <a href="#">清华大学 杨过 湖南</a>
                    </li>
                </ul>
           </div>   
        </div>
      </div> 
<script type="text/javascript">
$(function(){
  $('#container').masonry({
    // options
    itemSelector : '.item',
    columnWidth : 235
  });
});


</script>
<script type="text/javascript">
function display_actions(){
	//$("#act").css("display","");
	$(this).find(".actions").css("display","");
	//alert("hello");
}
</script>
<script>
	$('.members ul li').tooltip({
      selector: "a[rel=tooltip]"})
</script>
