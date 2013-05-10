class GroupInvitationship < ActiveRecord::Base
  attr_accessible :applied_group_id, :status, :invitation_id, :description
  belongs_to :applied_group, :class_name => "Group"
  belongs_to :invitation
  scope :active_invitation_ship_applied_by_group, 
          lambda { |group|where(["applied_group_id=? AND status=?", group.id,"active"]) }

  has_many :comments, :as => :commentable, :dependent => :destroy

  def self.accept(applied_group_id, invitation_id)
    group_invitationship = GroupInvitationship.find_by_applied_group_id_and_invitation_id(
                           applied_group_id, invitation_id)
    invitation = Invitation.find(invitation_id)
    begin
      #首先，将group_invitationship的status置为active，接着删除其他人的申请请求，最后将该邀请的status
      #置为active，使其别再显示在首页，以免别人再次请求
      GroupInvitationship.transaction do
        group_invitationship.update_attribute("status", "active")
        other_group_invitationships = GroupInvitationship.find_all_by_invitation_id(invitation_id)
        for other_group_invitationship in other_group_invitationships
          if group_invitationship != other_group_invitationship
            other_group_invitationship.destroy
          end
        end
        invitation.update_attribute("status", "active")

        invitation.create_conversation()
        group_invitationship.create_feed
        #删除applied_group在当天的其它应征帖
        group_invitations = GroupInvitationship.find_all_by_applied_group_id_and_status(applied_group_id,"pending")
        group_invitations.each do |group_invitation|
          if group_invitation.invitation.time == invitation.time
            group_invitation.destroy
          end
        end
      end
    end
  end

  def self.find_received_invitations_by_user(user)
    @my_invitations = Invitation.initiated_by_user(user)
    @ships = Hash.new
    @my_invitations.each do |my_invitation|
      if my_invitation.status != "active"
        @invitation_ships = GroupInvitationship.find_all_by_invitation_id(my_invitation.id)
        @ships[my_invitation.id] = @invitation_ships
      end
    end
    @ships
  end

  def create_feed
    initiate_group = invitation.initiate_group
    feed = initiate_group.team_leader.feeds.build(:model_name => "GroupInvitationship",
                                                  :item_id => id)
    feed.save
    feed = applied_group.team_leader.feeds.build(:model_name => "GroupInvitationship",
                                                  :item_id => id)
    feed.save
    (initiate_group.members | applied_group.members).each do |member|
      feed = member.feeds.build(:model_name => "GroupInvitationship",
                                :item_id => id)
      feed.save
    end
  end
end
