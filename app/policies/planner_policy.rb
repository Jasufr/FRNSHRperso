class PlannerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.planners
    end
  end

  def create?
    true
  end

end
