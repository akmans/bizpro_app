Rails.application.config.middleware.use OmniAuth::Builder do
        provider :yahoojp, ENV['YAHOOJP_KEY'], ENV['YAHOOJP_SECRET'], 
        {
                :scope => 'openid profile email address'
        }
end