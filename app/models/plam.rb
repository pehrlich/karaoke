class Plam
  include Mongoid::Document

  field :archive_id, type: String
  field :user_id, type: Integer

end