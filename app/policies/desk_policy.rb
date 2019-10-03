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

    def new?
      user.admin?
    end

    def new?
      user.admin?
    end

    def create?
      user.admin?
    end

end
