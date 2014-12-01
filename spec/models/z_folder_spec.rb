require 'rails_helper'

RSpec.describe ZFolder, type: :model do

  context "hierarchy" do
    before(:all) do
      @root = ZFolder.create label: ZFolder.root_label, folder: nil
    end

    it 'has root_label' do
      expect(ZFolder.root_label).not_to be_empty
    end

    it "should ask if it's root?" do
      hierarchy = double ZHierarchy
      expect(hierarchy).to receive(:root?).once
      @root.hierarchy = hierarchy

      @root.root?
    end

    it "should ask for the root folder" do
      hierarchy = double ZHierarchy
      expect(hierarchy).to receive(:root).once
      @root.hierarchy = hierarchy

      @root.root
    end

    it "should create only one root" do
      folder = ZFolder.create label: ZFolder.root_label

      expect(folder.valid?).to be false
      expect(folder.errors.count).to be == 1

      folder.folder = @root
      expect(folder.valid?).to be true
    end

    context "attaching data to a folder" do
      it "should attach a folder to a folder" do
        child_folder = @root.folders.create label: "root_child_1"
        expect(child_folder.folder).to be == @root
        expect(child_folder.class.name).to be == ZFolder.name
      end

      it "should attach a document to a folder" do
        child_document = @root.documents.create label: "document root_child_1"
        expect(child_document.folder).to be == @root
        expect(child_document.class.name).to be == ZDocument.name
      end
    end
  end

#@jtodoIMP the document structure creation then do the history
# context 'should have documents' do
#   before(:all) do
#     ZItem.destroy_all
#     f = ZFolder.root
#     f.folders.create!(label: 'F1')
#     f.documents.create!(label: 'D1')
#     @root = f
#   end
#
#   it 'should have 2 items' do
#     expect(@root.items.count).to eq(2)
#   end
#   it 'should have 1 document' do
#     expect(@root.documents.count).to eq(1)
#   end
#   it 'should have 1 folder' do
#     expect(@root.folders.count).to eq(1)
#   end
# end
#
# it 'should exists a root folder' do
#   expect(ZFolder.root).to_not be_nil
# end
#
# it 'root folder must have its folder set to nil' do
#   expect(ZFolder.root.folder).to be_nil
# end
end