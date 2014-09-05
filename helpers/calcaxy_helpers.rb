module CalcaxyHelpers
  def active_if_current(path)
    current_page.url.start_with?(path) ? 'active' : ''
  end

  def clear
    '<div class="spacer">&nbsp;</div>'
  end

  def supercloth(text)
    text = text.gsub(/"target=_blank/, '')
    text = text.gsub(/"target=blank/, '')
    rc = RedCloth.new(text)
    rc.hard_breaks = false
    rc.to_html
  end

  def as_calc(text)
   text.gsub(/\s([calc])/, ' <strong>\1</strong>').sub(/c/, "<strong>c</strong>")
  end

  def thumb_of(page, name)
    if page.attachment name
      image = image_tag page.attachment(name).public_filename, :size => "193x117"
      if page.attachment(:main)
        link_to image, page.attachment(:main).public_filename, :class => 'thumbnail'
      else
        image
      end
    end
  end
end
