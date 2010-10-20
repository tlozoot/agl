dirname = "#{RAILS_ROOT}/public/stimuli/hebrew/"

Dir.new(dirname).each do |old_name|
  unless old_name == "." || old_name == ".."
    new_name = File.basename(old_name, ".wav.mp3") + ".mp3"
    print "old name: #{old_name}; new name: #{new_name}\n"
    File.rename(dirname + old_name, dirname + new_name)
  end
end