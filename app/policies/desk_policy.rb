class DeskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

    def show?
      true
    end

    def update?
      user.admin?
    end

end
