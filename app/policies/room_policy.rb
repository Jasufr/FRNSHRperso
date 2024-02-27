class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.rooms
    end
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end
end