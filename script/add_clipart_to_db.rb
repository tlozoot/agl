@files = Dir.glob("#{RAILS_ROOT}/public/clipart/*.jpg").reject{ |f| f =~ /2/ }.map{ |f| File.basename(f, ".jpg").chop }

@files.each do |f|
  Clipart.create( :name => f )
end