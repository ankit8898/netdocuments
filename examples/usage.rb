require_relative '../lib/netdocuments'


client = Netdocuments::Client.new(client_secret: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                                  refresh_token: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')


#Fetch the token
client.get_token

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
