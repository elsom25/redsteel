class HomeController < ApplicationController
  after_filter :verify_policy_scoped, only: []

  def index
    @users = User.all
  end
end
