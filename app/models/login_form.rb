class ContactForm
    include ActiveModel::Model
    attr_accessor :name, :email, :message
    validates :name, :email, :message, presence: true
    def submit
      return false if invalid?
      # send acknowledgement reply, and admin notification emails, etc
      true
    end
  end