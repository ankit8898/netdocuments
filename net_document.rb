require 'httparty'
require 'awesome_print'
require_relative 'net_document/access_token'
require_relative 'net_document/base'
require_relative 'net_document/cabinet'
require_relative 'net_document/folder'


#Creating a folder
#ct = Dri::Folder.new({name: 'namaste',parent: '4844-5443-9970'})
#ap ct.create


#Get Folder Content
# at =  Dri::Folder.new({id: '4844-5443-9970'})
# ap at.folder_content

#Folders inside cabinet

folders = NetDocument::Cabinet.new(id: 'NG-2QORXCL4').folders
#ap folders

#ap folders.collect {|i| i['id']}

#folder_ids = folders.class

#Cabinet info

# info = Dri::Cabinet.new(id: 'NG-2QORXCL4').info
# ap info


def cabinet_with_folder_contents
	hsh = Hash.new
	folders = NetDocument::Cabinet.new(id: 'NG-2QORXCL4').folders
	ap folders
	folder_ids = folders.collect {|i| {id: i['id'],name: i['name']}}
	ap folder_ids
	folder_ids.each do |hh|
		hsh[hh[:name]] = Dri::Folder.new({id: hh[:id]}).folder_content
	end
	hsh
end

ap cabinet_with_folder_contents
