require 'json'
require 'httparty'
require 'awesome_print'
require_relative 'netdocuments/access_token'
require_relative 'netdocuments/base'
require_relative 'netdocuments/cabinet'
require_relative 'netdocuments/folder'
require_relative 'netdocuments/node'
require_relative 'netdocuments/document'


#Creating a folder
#ct = Netdocuments::Folder.new({name: 'namaste',parent: '4844-5443-9970'})
#ap ct.create


#Get Folder Content
# at =  Netdocuments::Folder.new({id: '4844-5443-9970'})
# ap at.folder_content


# Subfolder inside folder

#f = Netdocuments::Folder.new({id: '4827-8681-1170'}).subfolders
#ap f
#Folders inside cabinet

#folders = Netdocuments::Cabinet.new(id: 'NG-2QORXCL4').folders
#ap folders

#ap folders.collect {|i| i['id']}

#folder_ids = folders.class


#Update Document info

# doc = Netdocuments::Document.new(id: '4832-9209-5266')
# q1  = {'customAttributes' => [{"id" => "48","value" => 'a/b'}]}
# ap doc.update_info({query: q1.to_json})


#Update Folder info

# doc = Netdocuments::Folder.new(id: '4848-0256-8482')
# q1  = {'customAttributes' => [{"id" => "48","value" => 'a/b/c'}]}
# ap doc.update_info({query: q1.to_json})


#Get subfolders

folder = Netdocuments::Folder.new(id: '4827-8681-1170')
folder.subfolders.each do |node|
  ap "Updating: #{node.name}"
  node.update
end

# main = []
# main << folder_extraction(id: '4827-8681-1170',parent: '/Ankit')
# temp = main.clone.flatten!

# temp.reject! {|i| i.extension != 'ndfld'}
# ap main
# r = temp.collect do |i|
#   folder_extraction(id: i.id,parent: "#{i.parent}/#{i.name}")
# end


#Cabinet info

# info = Dri::Cabinet.new(id: 'NG-2QORXCL4').info
# ap info


def cabinet_with_folder_contents
  hsh = Hash.new
  folders = Netdocuments::Cabinet.new(id: 'NG-2QORXCL4').folders
  ap folders
  folder_ids = folders.collect {|i| {id: i['id'],name: i['name']}}
  ap folder_ids
  folder_ids.each do |hh|
    hsh[hh[:name]] = Netdocuments::Folder.new({id: hh[:id]}).folder_content
  end
  hsh
end

#ap cabinet_with_folder_contents
