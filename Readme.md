## Netdocuments


A Ruby wrapper for accessing [Netdocuments](https://www.netdocuments.com) api.

Official API documentation [available here](https://vault.netvoyage.com/neWeb2/delView.aspx?env=%2FQ21%2F8%2Fa%2Fm%2Fs%2F~121219174809946.nev&dn=1&v=9&dl=1&p=0&e=20160314&t=UqvBwPQjj1IVRRdzbSYLJVlpSCY%3D)



Installation
------


    gem install netdocuments


Usage Examples
------

Setup the configs

```ruby

Netdocuments.configure do |config|
  config.client_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.refresh_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.log_path      = '/path/you/want' #defaults to current_path/log/netdocuments.log
end

```

Initiate the client instance

```ruby

client = Netdocuments::Client.new

```

Fetch the token, it regenerates after 30 mins

```ruby
#Fetch the token
client.get_token

```

```ruby
# Cabinet
# ==================================================
cabinet = Netdocuments::Cabinet.new(client,id: 'NG-2QORXCL4')

# Cabinet folders
cabinet.folders


# Cabinet info
cabinet.info


# Folder
# =======================================================

folder = Netdocuments::Folder.new(client,id: '4815-5113-1938')

# Subfolders

folder.subfolders

# info

folder.info

# folder content

folder.folder_content

# update info

folder.update_info(query: {})
# Creating a folder
folder = Netdocuments::Folder.new(client,name: 'Foo folder',parent: '4815-5113-1938')
folder.create

# Documents
# ===================================================================================

document = Netdocuments::Document.new(client,id: '4824-5093-9170')

#info

document.info


#update info

document.update_info(query: {})

```
