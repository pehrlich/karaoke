class Jam
  include Mongoid::Document
  include Mongoid::Timestamps


  embeds_many :archive2s

  index "archives.user_id"

end
