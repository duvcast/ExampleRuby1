require 'rails-html-sanitizer'
require 'action_view/helpers/tag_helper'

# File actionview/lib/action_view/helpers/url_helper.rb, line 190
def link_to(name = nil, options = nil, html_options = nil, &block)
  html_options, options, name = options, name, block if block_given?
  options ||= {}

  html_options = convert_options_to_data_attributes(options, html_options)

  url = url_for(options)
  html_options["href".freeze] ||= url

  content_tag("a".freeze, name || url, html_options, &block)
end

module RecipesHelper
  def strip_tags(html)
        self.class.full_sanitizer.sanitize(html, encode_special_chars: false)
    end

def image_tag(source, options={})
    options = options.symbolize_keys
    check_for_image_tag_errors(options)

    src = options[:src] = path_to_image(source)

    unless src =~ /^(?:cid|data):/ || src.blank?
      options[:alt] = options.fetch(:alt){ image_alt(src) }
    end

    options[:width], options[:height] = extract_dimensions(options.delete(:size)) if options[:size]
    tag("img", options)
  end

  def check_for_image_tag_errors(options)
          if options[:size] && (options[:height] || options[:width])
            raise ArgumentError, "Cannot pass a :size option with a :height or :width option"
          end
  end
end
