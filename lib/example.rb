require_relative 'netdocuments'
#Creating a folder

# ap 'ssss'
# 3200.times do |i|
#   ap 'j'
#   ct = Netdocuments::Folder.new({name: "Folder1.1.#{i}",parent: '4831-7989-8658'})
#   ct.create
# end


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

# folder = Netdocuments::Folder.new(id: '')
# folder.subfolders.each do |node|
#   ap "Updating: #{node.name}"
#   node.update
# end

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


# def cabinet_with_folder_contents
#   hsh = Hash.new
#   folders = Netdocuments::Cabinet.new(id: 'NG-2QORXCL4').folders
#   ap folders
# end
#a = Time.now
#sleep 5
#b = Time.now

a = Time.now
aa = Netdocuments::Cabinet.new(id: 'NG-2QORXCL4')
e = aa.find_folder_tree_and_update_file_path
#aa = Netdocuments::Folder.new({id: '4818-0246-2498'}).folder_content

#r = ":Q5:5:y:g:y:^F150220161118187.nev"[1..-1].gsub(':','/')
#ab =Netdocuments::Folder.new({id: r}).folder_content
b = Time.now


ap "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
ap "Total time taken: #{TimeDifference.between(a,b).in_minutes} minutes--#{e}"
ap "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
