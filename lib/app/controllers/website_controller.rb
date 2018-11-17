# frozen_string_literal: true

class WebsiteController < Phos
  get '/*' do
    render :html, :index
  end
end
