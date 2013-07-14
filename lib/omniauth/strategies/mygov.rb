require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Mygov < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "mygov"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "https://my.usa.gov", :token_url => "/oauth/authorize"}

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] || nil }

      info do
        {
          :email => raw_info['email'] || nil,
          :id => raw_info['id'] || nil,
          :title => raw_info['title'] || nil,
          :first_name => raw_info['first_name'] || nil,
          :middle_name => raw_info['middle_name'] || nil,
          :last_name => raw_info['last_name'] || nil,
          :suffix => raw_info['suffix'] || nil,
          :address => raw_info['address'] || nil,
          :address2 => raw_info['address2'] || nil,
          :city => raw_info['city'] || nil,
          :state => raw_info['state'] || nil,
          :zip => raw_info['zip'] || nil,
          :phone_number => raw_info['phone_number'] || nil,
          :mobile_number => raw_info['mobile_number'] || nil,
          :gender => raw_info['gender'] || nil,
          :marital_status => raw_info['marital_status'] || nil,
          :is_parent => raw_info['is_parent'] || nil,
          :is_retired => raw_info['is_retired'] || nil,
          :is_veteran => raw_info['is_veteran'] || nil,
          :is_student => raw_info['is_student'] || nil
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/profile').parsed
      end
    end
  end
end