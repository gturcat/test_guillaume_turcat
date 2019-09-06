class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:user => user)
      end
    end
  end


    def create?
      true
    end

    def show?
      if user.admin?
        true
      else
        record.user == user
      end
    end
end
