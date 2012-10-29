class User
  include Mongoid::Document

  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String

  class Email
    include Mongoid::Document

    field :email, type: String

    validates :email, presence: true, uniqueness: {case_sensitive: false}
  end

end
