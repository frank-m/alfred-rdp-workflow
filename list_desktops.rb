require './alfred_feedback.rb'
require 'csv'

query = ''
if ARGV.length > 0
	query = ARGV[0].downcase
end

raw_bookmarks = `'/Applications/Microsoft Remote Desktop.app/Contents/MacOS/Microsoft Remote Desktop' --script bookmark list`
csv_bookmarks = CSV.parse(raw_bookmarks)

if query.length > 0
  desktops = csv_bookmarks.find_all {|bookmark| bookmark[0].downcase.include?(query)}
end

feedback = Feedback.new
if desktops.size() > 0
	desktops.each do |desktop|
		feedback.add_item({:title => desktop[0], :subtitle => "Open desktop"})
	end
else
	feedback.add_item({:title => 'No matching desktop found', :subtitle => "Can't open desktop", :arg => '##notfound##'})
end

puts feedback.to_xml
