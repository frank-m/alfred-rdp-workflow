require './alfred_feedback'
require 'csv'

mrdpApp = '/Applications/Microsoft Remote Desktop.app/Contents/MacOS/Microsoft Remote Desktop'

def export_bookmark_list(mrdpApp)
  raw_bookmarks = `'#{mrdpApp}' --script bookmark list`
  CSV.parse(raw_bookmarks)
rescue StandardError => e
  warn "Something went wrong while exporting the bookmark list from app '#{mrdpApp}'."
  warn 'Please see the exception below: '
  warn e.inspect
  exit(1)
end

def find_bookmarks(bookmark_list, query)
  bookmark_list.find_all { |bookmark| bookmark[0].downcase.include?(query) }
end

def generate_feedback(bookmarks)
  feedback = Feedback.new
  if !bookmarks.empty?
    bookmarks.each do |bookmark|
      feedback.add_item({ title: bookmark[0], subtitle: 'Open desktop', arg: bookmark[1].strip })
    end
  else
    feedback.add_item({ title: 'No matching desktop found', subtitle: "Can't open desktop", arg: '##notfound##' })
  end
  puts feedback.to_xml
end

if !ARGV[0].empty?
  query = ARGV[0].downcase
  bookmark_list = export_bookmark_list(mrdpApp)
  bookmarks = find_bookmarks(bookmark_list, query)
  generate_feedback(bookmarks)
else
  warn 'No Bookmark name received from Alfred, exiting...'
  exit(1)
end