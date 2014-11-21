class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a? User
      # ContentEntities
      can :create, ContentEntity
      can :update, ContentEntity, user_id: user.id
      can :destroy, ContentEntity, user_id: user.id
      can :read, ContentEntity, user_id: user.id
      can :read, ContentEntity, group_id: user.group_ids
      # Groups
      can :create, Group
      can :manage, Group, owner_id: user.id
      can :read, Group do |group|
        group.user_ids.include? user.id
      end
      # Users
      can :update, User, id: user.id
      # Comments
      can :create, Comment
      can :read, Comment
      can :destroy, Comment, user_id: user.id
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
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
