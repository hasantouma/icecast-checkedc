#!/usr/bin/ruby

output = `find . -type f`

verbose = false
flag = false

if verbose then
  puts "verbose is true"
else
  puts "verbose is false"
end

if flag then
  puts "flag is true"
else
  puts "flag is false"
end

puts "printing source files"

c_count = 0
output.each_line do |line|
  if line =~ /\.\/(.*)\.checked\.c/ then
    c_count += 1
    source_file_name = $1 + ".c"
    checked_file_name = $1 + ".checked.c"
    if verbose then print "source file name: " + source_file_name + "\n" end
    if verbose then print "checked file name: " + checked_file_name + "\n" end
    if verbose then print "line: " + line end

    command = "mv " + checked_file_name + " " + source_file_name
    if verbose then print "call command: " + command + "\n" end
    if flag then
      system command
    end

    if verbose then print "\n" end

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
    if verbose then print "source file name: " + source_file_name + "\n" end
    if verbose then print "checked file name: " + checked_file_name + "\n" end
    if verbose then print "line: " + line end

    command = "mv " + checked_file_name + " " + source_file_name
    if verbose then print "call command: " + command + "\n" end
    if flag then
      system command
    end

    if verbose then print "\n" end

  end
end

puts "header count: " + h_count.to_s


