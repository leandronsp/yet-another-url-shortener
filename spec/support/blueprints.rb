require 'machinist/active_record'

User.blueprint do
  name { 'Chuck Norris' }
  email { 'chuck@norris.com' }
  password { '123' }
  password_confirmation { '123' }
end

Url.blueprint do
  url { 'http://chuck.com/norris.html' }
end
