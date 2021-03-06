<% content_for :stylesheet do %>
  <%= stylesheet_link_tag "bootstrap_and_overrides", "bootswatch", "conversations", "docs" %>
<% end %>
<div class="container">
  <div class="row">
    <div class="span3" style="position:fixed">
      <h3>会话列表</h3>
      <ul id='conversation_list'>
        Group
        <% current_user.related_groups.each do |group| %>
          <li>
          <%= link_to group.name, { :controller => "conversations" , :group => group.id} ,
                      :method => "post",
                      :remote => true,
                      :id => "conversation_link_group_"+group.id.to_s %>

          </li>
        <% end %>
        Invitation
        <% current_user.related_active_invitations.each do |invitation| %>
          <li>
          <%= link_to invitation.initiate_group.name + " vs " + invitation.applied_groups[0].name,
                      { :controller => "conversations" , :invitation => invitation.id} ,
                      :method => "post",
                      :remote => true,
                      :id => "conversation_link_invitation_"+invitation.id.to_s %>
          </li>
        <% end %>


      </ul>
      <h3>成员列表</h3>
      <ul id='member_list'>
        <li>luojm</li>
        <li>luojm2</li>
        <li>luojm3</li>
        <li>luojm4</li>
      </ul>
    </div>
    <div class="span9" id="conversations_container">
    </div>
  </div>
</div>
