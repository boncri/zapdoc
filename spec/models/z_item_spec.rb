require 'rails_helper'

RSpec.describe ZItem, :type => :model do
  context 'Database Mapping' do
    it { should have_db_column(:id).of_type(:uuid) }
    it { should have_db_column(:label).of_type(:string) }
    it { should have_db_column(:custom_attributes).of_type(:hstore) }
    it { should have_db_column(:tags).of_type(:text) }
    it { should have_db_column(:revision).of_type(:integer) }
    it { should have_db_column(:format_identifier).of_type(:string) }
    it { should have_db_column(:mime_type).of_type(:string) }
    it { should have_db_column(:folder_id).of_type(:integer) }
    it { should have_timestamps }

    it 'should have an id alias to identifier' do
      should have_an_alias_attribute(:id,:identifier)
    end

    it 'should have an alias for z_history named history' do
      should have_an_alias(:z_history, :history)
    end

    it 'should have a relation with history' do
      should have_many(:z_history).dependent(:destroy)
    end

    it 'should validate presence of label' do
      should validate_presence_of(:label)
    end

    it 'should validate persisted revision record' do
      item = ZItem.create(label: '1')
      expect {item.should validate_presence_of(:revision)}
      expect {item.should validate_numericality_of(:revision)}
    end
  end

  #@jtodoLOW here you can see that all thoose responsability
  #@jtodoLOW should be putted in a revision class asap to keep it Solid
  context 'revision' do
    it 'should have revision 1 on creation' do
      item = ZItem.create(label: '1')
      expect(item.revision).to eq(1)
    end

    context 'with two revisions' do
      let(:item) { ZItem.create(label: '1') }
      before(:each) do
        item.update_attribute(:label, '2')
      end

      it 'should update revision after save' do
        expect(item.revision).to eq(2)
      end

      it 'should create history on save' do
        expect(item.histories.count).to eq(1)
      end

      it 'should create an history item on save' do
        expect(item.histories.nil?).to be(false)
      end
    end
  end

  #@jtodoIMP fix this in the end
  xit 'should have a default folder' do
    item = ZItem.create(label: '1')
    expect(item.folder.identifier).to eq(ZFolder.root.identifier)
  end

end
