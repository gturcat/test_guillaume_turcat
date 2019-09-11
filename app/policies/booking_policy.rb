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

    def admin?
      user.admin?
    end

    def pdf_ready?
      user.admin?
    end

    def my_reservations?
      true
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
