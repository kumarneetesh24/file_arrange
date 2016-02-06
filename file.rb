if(ARGV.length==0)
	abort("Require one argument") #termination for less input 
elsif(ARGV.length>1)
	abort("invalid input") #termintaion for more than one input
end

Dir.chdir(ARGV[0])  #setting argument directory as directory of process
file_list = Dir.entries(Dir.pwd) #ls in ruby
file_list = file_list.reject{ |f| f==$0.to_s}
ext_list = []
file_list.each{ |f| ext_list.push(File.extname f) }
main_list = ext_list.reject { |f| f.to_s.empty?}
main_list = main_list.uniq
main_list.each{ |m| m.delete! '.'}
main_list.each{|f| Dir.mkdir(File.join(Dir.pwd, f),0775)}
