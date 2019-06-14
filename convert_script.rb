#!/usr/bin/ruby

output = `find . -type f`

puts "printing source files"

c_count = 0
output.each_line do |line|
  if line =~ /\.\/(.*)\.checked\.c/ then
  	c_count += 1
    source_file_name = $1 + ".c"
    checked_file_name = $1 + ".checked.c"
    print "source file name: " + source_file_name + "\n"
    print "checked file name: " + checked_file_name + "\n"
    print "line: " + line

    command = "mv " + checked_file_name + " " + source_file_name
    print "call command: " + command + "\n"
    # system command

    print "\n"

  end
end

puts "source count: " + c_count.to_s


puts "printing header files"

h_count = 0
output.each_line do |line|
  if line =~ /\.\/(.*)\.checked\.h/ then
  	h_count += 1
    source_file_name = $1 + ".h"
    checked_file_name = $1 + ".checked.h"
    print "source file name: " + source_file_name + "\n"
    print "checked file name: " + checked_file_name + "\n"
    print "line: " + line

    command = "mv " + checked_file_name + " " + source_file_name
    print "call command: " + command + "\n"
    # system command

    print "\n"

  end
end

puts "header count: " + h_count.to_s


