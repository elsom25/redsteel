class UserPolicy < ApplicationPolicy
  def index?   ; @user.admin? ; end
  def destroy? ; @user.admin? ; end

  def update?
    @user.admin? || @user == @record
  end

  def show?
    self.update?
  end

  class Scope
    vattr_initialize :user, :scope
    def resolve
      return unless user
      if user.admin?
        scope.all
      else
        [ scope.find(user.id) ]
      end
    end
  end
end
