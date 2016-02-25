#!/usr/bin/env ruby

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
basefile = File.expand_path(__FILE__).to_s
file_list = file_list.reject{ |f| File.expand_path(f) == basefile || File.expand_path(f) == "."+basefile+".swp" || (File.directory? f)}

# file moving and cheking if the file 
file_list.each do |f|
	fol = (File.extname f).to_s
	if fol.empty? 
		puts "file name #{f} with no extension"
		puts "1 igonre"
		puts "2 move to others"
		inp = STDIN.gets.chomp.to_i
		case inp
		when 1
			next
		when 2 
			fol = "others"
		else 
			puts "invalid input try again"
		end
	end
	fol.delete! '.'
	Dir.mkdir(File.join(Dir.pwd, fol),0775) unless Dir.exist? fol
	if Dir.entries(fol).include?(f) 
		puts "file name #{f} exist"
		puts "1. rename"
		puts "2. overwrite"
		puts "3. ignore"
		inp = STDIN.gets.chomp.to_i	
		case inp
		when 1
			fname = f
			while true
				print "enter file name: "
				fname =  STDIN.gets.chomp
				fname = fname +"."+ fol if (File.extname fname).to_s.empty? && fol != "others"
				if Dir.entries(fol).include?(fname)
					puts "name exist try another"
				else 
					break
				end
			end
			FileUtils.mv(f,fol+"/"+fname)
		when 2
			FileUtils.mv(f,fol+"/"+f)
		when 3
			next
		else 
			puts "invalid input try again"
			redo
		end
	else
		FileUtils.mv(f,fol+"/"+f)
	end
end