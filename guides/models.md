# Models

The following is a base template for an ActiveRecord model `Customer`.

## Key Points

  * Avoid ActiveRecord callbacks where possible, prefer Service Objects architecture to store any business

  * Order associations, scopes and validations alphabetically

  * Aim to remove business logic that is not directly related to reading from or writing to the database

## Template

```ruby
class Customer < ActiveRecord::Base
  # Inclusions and extensions
  include Module

  # Public custom attributes
  attr_accessor :trigger_activation_mailer

  # Constants
  DEFAULT_COUNTRY = 'Poland'.freeze

  # Associations
  belongs_to :company
  has_many :orders
  has_one :address

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Callbacks, in lifecycle, then alphabetical order (if you really have to)
  before_validation :parse_name
  after_create :send_email

  # Scopes
  scope :is_active, -> { where(active: true) }

  # Nested attributes
  accepts_nested_attributes_for :orders

  # Delegate methods
  delegate :post_code, to: :address

  # Gems methods calls
  enumerize :title, in: %i[mr ms]
  mount_uploader :avatar, AvatarUploader

  # Class methods
  def self.activate
    find_each do |customer|
      customer.update_attributes(active: true)
    end
  end

  # Instance methods
  def age
    calculate_age(dob: dob)
  end

  # Protected methods
  protected

  def parse_name
    # some logic
  end

  # Private methods
  private

  def send_email
    # we shouldn't send emails from AR models
  end

  def calculate_age(dob:)
    # some calculation
  end
end
```
