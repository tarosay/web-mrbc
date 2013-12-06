class Compiler < ActiveRecord::Base
  attr_accessible :options, :rb
  mount_uploader :rb, RbUploader
end
