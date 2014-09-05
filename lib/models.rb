Attachment = Struct.new(:id, :content_type, :filename, :size, :description,
                        :parent_id, :thumbnail, :width, :height, :created_at,
                        :updated_at, :page_id, :label) do

  def public_filename
    "/files/xymedia/0000/#{id.to_s.rjust(4, '0')}/#{filename}"
  end

  def image?
    content_type == 'image/gif' || content_type == 'image/jpeg' || content_type == 'image/png'
  end

  def pdf?
    content_type == 'application/pdf'
  end

end

Meta = Struct.new(:id, :page_id, :name, :value) do
end


Page = Struct.new(:id, :parent_id, :title, :position, :depth, :state,
                  :mime, :content, :created_at, :updated_at) do


  def children
    @children ||= Repo.all('Page').select {|p| p.parent_id.to_i == id.to_i }.sort_by! {|p| p.position }
  end

  def attachments
    @attachments ||= Repo.all('Attachment').select {|a| a.page_id.to_i == id.to_i }
  end

  def metas
    @metas ||= Repo.all('Meta').select {|a| a.page_id.to_i == id.to_i }
  end

  def attachment(label)
    Repo.all('Attachment').find {|a| a.page_id.to_i == id.to_i && a.label == label.to_s }
  end

  def meta(name)
    meta = Repo.all('Meta').find {|a| a.page_id.to_i == id.to_i && a.name == name.to_s }
    meta.present? ? meta.value : ''
  end

end
