class User
  include Mongoid::Document

  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: {scope: :provider}
  validates :name, presence: true
  validate :whitelist_email

  def whitelist_email
    unless User::Email.where(email: email).exists?
      errors.add :email, 'must be whitelisted for an account by an administrator.'
    end
  end

  class Email
    include Mongoid::Document

    field :email, type: String

    validates :email, presence: true, uniqueness: {case_sensitive: false}
  end

end
