class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      if user.persisted?
        can [:create, :show], Group
        can :read, Profile
        can :create, Album
      end
      can :manage, Invitation do |invitation|
        invitation.initiate_group.try(:team_leader) == user
      end
      can :manage, Message do |message|
      end
      can :manage, Profile,   :user_id => user.id
      can :manage, Group  do |group|
        group.try(:team_leader) == user
      end
      can :invite_posts, Group do |group|
        group.team_leader == user || group.members.include?(user)
      end
      can :applied_groups, Invitation do |invitation|
        initiate_group = invitation.initiate_group
        initiate_group.team_leader == user || initiate_group.members.include?(user)
      end
      can :manage, Album do |album|
        album.try(:user) == user
      end
      can :manage, Photo do |photo|
        photo.album.try(:user) == user
      end
      can :accept, GroupInvitationship do |group_invitationship|
        group_invitationship.invitation.initiate_group.team_leader == user
      end
      can :create, GroupGroupship do |group_groupship|
        group_groupship.applied_group.status == "active" &&
        group_groupship.target_group.status == "active"
      end

      can [:accept,:destroy], GroupGroupship do |group_groupship|
        group_groupship.target_group.team_leader == user
      end

      can [:sended_posts, :invite_posts], Group do |group|
        group.team_leader == user || group.members.include?(user)
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
