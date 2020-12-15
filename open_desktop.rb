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

desktops.each do |desktop|
  bookmark_uri = `'/Applications/Microsoft Remote Desktop.app/Contents/MacOS/Microsoft Remote Desktop' --script bookmark export #{desktop[1]} --uri`
  `open '#{bookmark_uri.strip}' `
end
