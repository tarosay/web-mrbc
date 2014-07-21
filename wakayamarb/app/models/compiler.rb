class Compiler < ActiveRecord::Base
  mount_uploader :rb, RbUploader
end
