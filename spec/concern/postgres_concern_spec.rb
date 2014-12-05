require 'rails_helper'

class FakeController < ApplicationController
  include Concerns::Postgres

  valid_id nil, '0'

  def index
    head :ok
  end
end

RSpec.describe FakeController, type: :request do

  before(:all) do
    Rails.application.routes.draw do
      get '/fake(/:id)', to: 'fake#index'
    end
  end
  after(:all) do
    Rails.application.reload_routes!
  end

  context 'validation' do
    it 'should check for valid postgres id' do
      expect(subject.send("valid_id?", SecureRandom.uuid) ).to be_truthy
      expect(subject.send("valid_id?", "ads-das-ddd") ).to be_falsy
    end

    it 'should validate if id is in the valid_ids field' do
      expect(subject.send("valid_id?", "0") ).to be_truthy
      expect(subject.send("valid_id?", nil) ).to be_truthy
    end
  end

  context 'id validation' do
    it 'should return success if id is not given' do
      get '/fake'
      expect(response).to be_success
    end

    it 'should return success if id is in the valid_ids field' do
      get '/fake/0'
      expect(response).to be_success
    end
  end

  context 'folder_id validation' do
    it 'should return not_found if folder_id is given and is invalid id' do
      get '/fake?folder_id=fake123'
      expect(response).to have_http_status :not_found
    end

    it 'should return success if folder_id is in the valid_ids field' do
      get '/fake?folder_id=0'
      expect(response).to be_success
    end
  end
end