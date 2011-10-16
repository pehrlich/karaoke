class Archive
  include Mongoid::Document

  include Mongoid::Timestamps

  field :archive_id, type: String
  field :user_id, type: Integer

  embedded_in :jam, :inverse_of => :archives

end