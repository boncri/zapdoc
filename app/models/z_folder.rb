class ZFolder < ZItem
  has_many :documents, class_name: 'ZDocument', dependent: :destroy
  has_many :folders, class_name: 'ZFolder', dependent: :destroy
  has_many :items, class_name: 'ZItem', dependent: :destroy

  def self.root
    ZFolder.find_or_create_by!(label: '__ROOT__')
  end

  def root?
    self.folder.nil?
  end
end
