require 'sinatra'
require 'dm-core'

# Configure DataMapper to use the App Engine datastore
DataMapper.setup(:default, "appengine://auto")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :address, Text
  property :phone, Text
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  @contacts = Contact.all
  erb :index
end

post '/' do
  Contact.create(:name => params[:name], :address => params[:address], :phone => params[:phone])
  redirect '/'
end

__END__

@@ index
<html>
  <head>
    <title>Contacts</title>
  </head>
  <body style="font-family: sans-serif;">
    <img src="/images/jrubyonappengine.jpeg">
    <h1>Add Contact</h1>

    <form method=post>
      <input type=text name="name" rows="3"></textarea>
      <input type=text name="address" rows="3"></textarea>
      <input type=text name="phone" rows="3"></textarea>
      <input type=submit value="Add">
    </form>

    <h2>Your Contacts</h2>

    <% @contacts.each do |contact| %>
      <p><%=h contact.name %> | <%=h contact.address %> | <%=h contact.phone %></p>
    <% end %>

  </body>
</html>
