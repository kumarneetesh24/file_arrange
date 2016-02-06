require 'fileutils' #for moving files across directories

# arguments checking
if(ARGV.length==0)
	abort("Require one argument") #termination for less input 
elsif(ARGV.length>1)
	abort("invalid input") #termintaion for more than one input
end

# main function for arranging 
Dir.chdir(ARGV[0])  #setting argument directory as directory of process
file_list = Dir.entries(Dir.pwd) #ls in ruby
dir_list = file_list.reject{ |f| /\./ =~ f}
file_list = file_list.reject{ |f| f==$0.to_s || f=="."+$0.to_s+".swp" || f =~ /^\./ || !(f =~ /\./ )}
ext_list = []
file_list.each{ |f| ext_list.push(File.extname f) }
main_list = ext_list.reject { |f| f.to_s.empty?}
main_list = main_list.uniq
main_list.each{ |m| m.delete! '.'}
#puts file_list
#puts dir_list
main_list.each do |f| 	 
	Dir.mkdir(File.join(Dir.pwd, f),0775) unless dir_list.include?(f)
end
file_list.each do |f|
	fol = (File.extname f).to_s
	fol.delete! '.'
	FileUtils.mv(f,fol+"/"+f);
end


