require 'sinatra'
require 'rest_client'

require 'json'

get '/:number' do
    resp = RestClient.get "https://staging.api.telstra.com/v1/oauth/token?client_id=[client_id]&client_secret=[secret]&grant_type=client_credentials&scope=SMS"
    token = JSON.parse(resp)["access_token"]
    header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
    RestClient.post "https://staging.api.telstra.com/v1/sms/messages", {to: params[:number], body: "Hi Allen, we are at the front door. This has been sent using the Telstra API >:)"}.to_json, header
end
