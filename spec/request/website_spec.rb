# frozen_string_literal: true

require 'app/phos'
require 'app/controllers/website_controller'
require 'spec_helper'

RSpec.describe 'home path' do
  let(:app) { WebsiteController.new }
  let(:response) { get '/' }

  it 'status is 200' do
    expect(response).to be_ok
  end

  it 'gives content from homepage' do
    expect(response.body).to have_tag('#root')
  end
end
