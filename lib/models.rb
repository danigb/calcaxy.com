Attachment = Struct.new(:id, :content_type, :filename, :size, :description,
                        :parent_id, :thumbnail, :width, :height, :created_at,
                        :updated_at, :page_id, :label) do

  def public_filename
    filename
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



  def attachment(name)
    Repo.all('Attachment').find {|a| a.page_id.to_i == id.to_i && a.label == name }
  end
end
