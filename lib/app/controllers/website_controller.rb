class WebsiteController < Phos
  get '/*' do
    render :html, :index
  end
end

