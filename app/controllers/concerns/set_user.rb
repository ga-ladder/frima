module SetUser
  extend ActiveSupport::Concern

  included do
    before_action :set_user, except: [:delete, :sign_up_way]

  end
  def set_user
    @user = ::User.find(current_user.id)
  end
end
