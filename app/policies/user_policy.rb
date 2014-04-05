class UserPolicy < ApplicationPolicy
  def index?   ; @user.admin? ; end
  def update?  ; @user.admin? ; end
  def destroy? ; @user.admin? ; end

  def show?
    @user.admin? || User.find(params[:id]) == @user
  end

  class Scope
    vattr_initialize :user, :scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.find(user.id)
      end
    end
  end
end
