class Jam
  include Mongoid::Document
  include Mongoid::Timestamps


  embeds_many :archives

  index "archives.user_id"

end
