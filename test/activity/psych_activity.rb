# TODO(uwe): Remove when we stop supporting Ruby 1.8 mode
if RUBY_VERSION < "1.9"
  require 'jruby'
  require 'rbconfig'
  org.jruby.ext.psych.PsychLibrary.new.load(JRuby.runtime, false)
  $LOADED_FEATURES << 'psych.so'
  $LOAD_PATH << File.join(Config::CONFIG['libdir'], 'ruby/1.9')
end
# TODO end

with_large_stack{require 'psych.rb'}

Psych::Parser
Psych::Handler

require 'ruboto'

ruboto_import_widgets :Button, :LinearLayout, :TextView

$activity.handle_create do |bundle|
  setTitle File.basename(__FILE__).chomp('_activity.rb').split('_').map { |s| "#{s[0..0].upcase}#{s[1..-1]}" }.join(' ')

  setup_content do
    linear_layout :orientation => LinearLayout::VERTICAL do
      @decoded_view = text_view :id => 42, :text => Psych.load('--- foo')
      # @encoded_view = text_view :id => 43, :text => Psych.dump("foo")
    end
  end

end
